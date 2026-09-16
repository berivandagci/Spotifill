//
//  SpotifyHomeView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

@Observable
final class SpotifyHomeViewModel {
    let router: AnyRouter?
    var currentUser: User? = nil
    var selectedCategory: SpotifyCategory? = nil
    var products: [Product] = []
    var productRows: [ProductRow] = []

    init(router: AnyRouter? = nil) {
        self.router = router
    }

    func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
        } catch {
            print("Kullanıcı çekilirken hata oluştu: \(error)")
            currentUser = .mock
        }
        
        do {
            let allProducts = try await DatabaseHelper().getProducts()
            products = Array(allProducts.prefix(8))
            
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
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain && nsError.code == -999 {
                return
            }
            print("Ürünler çekilirken hata oluştu: \(error)")
        }
    }
}

struct SpotifyHomeView: View {
    @Environment(\.router) var router
    @State private var viewModel: SpotifyHomeViewModel

    init(viewModel: SpotifyHomeViewModel = SpotifyHomeViewModel()) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 24) {
                            recentsSection
                            
                            if let product = viewModel.products.first {
                                newReleasedSection(product: product)
                            }
                            
                            listRows
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        
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
            await viewModel.getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    if let currentUser = viewModel.currentUser {
                        ImageLoaderView(urlString: currentUser.image)
                            .frame(width: 30, height: 30)
                            .background(.spotifyWhite)
                            .clipShape(Circle())
                            .onTapGesture {
                                let activeRouter = viewModel.router ?? router
                                activeRouter.dismissScreen()
                            }
                    }
                    
                    ForEach(SpotifyCategory.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelection: category == viewModel.selectedCategory
                        )
                        .onTapGesture {
                            viewModel.selectedCategory = category
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
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: viewModel.products) { product in
            if let product {
                SpotifyRecentlyCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton(.press) {
                    goToPlaylistView(product: product)
                }
            }
        }
    }
    
    private func goToPlaylistView(product: Product) {
        let userToPass = viewModel.currentUser ?? .mock
        let activeRouter = viewModel.router ?? router
         
        activeRouter.showScreen(.push) { _ in
            SpotifyPlayListView(product: product, user: userToPass)
        }
    }
    
    private func newReleasedSection(product: Product) -> some View {
        SpotifyReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category, // .rawValue buradan silindi
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                goToPlaylistView(product: product)
            }
        )
        .asButton(.press) {
            goToPlaylistView(product: product)
        }
    }
    
    private var listRows: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.productRows, id: \.title) { row in
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
                                    goToPlaylistView(product: product)
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
    RouterView { router in
        SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
    }
}
