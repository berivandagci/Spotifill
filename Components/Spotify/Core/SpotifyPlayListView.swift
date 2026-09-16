//
//  SpotifyPlayListView.swift
//  Components
//
//  Created by beri on 14.09.2026.
//

import SwiftUI

struct SpotifyPlayListView: View {
    var product: Product = .mock
    var user: User = .mock
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        title: product.title,
                        subtitle: product.brand ?? product.category.rawValue,
                        imageName: product.firstImage
                    )
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category.rawValue,
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
                            imageName: item.firstImage,
                            title: item.title,
                            subtitle: item.brand
                        )
                        .padding(.horizontal, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            print("Veri çekerken hata oluştu: \(error)")
        }
    }
}

#Preview {
    SpotifyPlayListView(product: .mock)
}
