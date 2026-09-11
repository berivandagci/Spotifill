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
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 8) {
                            NonLazyHGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
                                if let product {
                                    SpotifyRecentlyCell(
                                        imageName: product.firstImage,
                                        title: product.title
                                    )
                                }
                            }
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
            products = try await DatabaseHelper().getProducts()
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
}

#Preview {
    SpotifyHomeView()
}
