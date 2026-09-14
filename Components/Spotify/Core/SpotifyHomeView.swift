//
//  SpotifyHomeView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//
import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: SpotifyCategory? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 24, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 24) {
                            recentsSection
                            
                            if let product = products.first {
                                newReleasedSECTION(product: product)
                            }
                            
                            listRows
                        }
                        .padding(.horizontal, 16)
                        
                        ForEach(0..<20, id: \.self) { _ in
                            Rectangle()
                                .fill(.spotifyDarkGray)
                                .frame(width: 200, height: 200)
                        }
                    } header: {
                        header
                    }
                }
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({ $0.brand }))
            for brand in allBrands {
                let filteredProducts = products.filter({ $0.brand == brand })
                rows.append(ProductRow(
                    title: brand?.capitalized ?? "Diğer",
                    product: filteredProducts
                ))
            }
            productRows = rows
        } catch {
            print("Veri çekerken hata oluştu: \(error)")
        }
    }
    
    private var header: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    if let currentUser {
                        ImageLoaderView(urlString: currentUser.image)
                            .frame(width: 30, height: 30)
                            .background(.spotifyWhite)
                            .clipShape(Circle())
                            .onTapGesture {
                                
                            }
                    }
                    
                    ForEach(SpotifyCategory.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelection: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 8)
        .background(Color.spotifyBlack)
    }
    
    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentlyCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton(.press) {
                    
                }
            }
        }
    }
    
    private func newReleasedSECTION(product: Product) -> some View {
        SpotifyRelaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category.rawValue,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {
                
            },
            onPlayPresed: {
                print("Oynatılıyor: \(product.title)")
            }
        )
    }
    
    private var listRows: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(productRows, id: \.title) { row in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(row.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.spotifyWhite)
                        
                        VStack(spacing: 12) {
                            ForEach(row.product) { product in
                                ImageTitleRowCell(
                                    imageSize: 120,
                                    imageName: product.firstImage,
                                    title: product.title
                                )
                                .asButton(.press) {
                                    
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SpotifyHomeView()
}
