//
//  SpotifyPlayListView.swift
//  Components
//
//  Created by beri on 14.09.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlayListView: View {
    @Environment(\.router) var router
    var product: Product = .mock
    var user: User = .mock
    @State private var products: [Product] = []
    @State private var showHeader: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? product.category, // .rawValue silindi
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category, // .rawValue silindi
                        onAddToPlaylistPressed: nil,
                        onSharedPressed: nil,
                        onDownLoadPressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { item in
                        SongRowCell(
                            imageSize: 50,
                            imageName: item.thumbnail,
                            title: item.title,
                            subtitle: item.brand,
                            onCellPressed: {
                                goToPlaylistView(product: item)
                            },
                            onEllipsisPressed: {
                                
                            }
                        )
                        .padding(.horizontal, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            header
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            let allProducts = try await DatabaseHelper().getProducts()
            let filtered = allProducts.filter { $0.brand == product.brand }
            products = filtered.isEmpty ? allProducts : filtered
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain && nsError.code == -999 {
                return
            }
            print("Veri çekerken hata oluştu: \(error)")
        }
    }
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlayListView(product: product, user: user)
        }
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(product.title)
                    .font(.headline)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity)
                    .opacity(showHeader ? 1 : 0)
                
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.spotifyWhite)
                        .padding(10)
                        .background(Color.spotifyBlack.opacity(0.6))
                        .clipShape(Circle())
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 44)
            .padding(.top, 8)
            .background(showHeader ? Color.spotifyDarkGray : Color.clear)
            
            Spacer()
        }
        .animation(.easeInOut(duration: 0.2), value: showHeader)
    }
}

#Preview {
    RouterView { _ in
        SpotifyPlayListView()
    }
}
