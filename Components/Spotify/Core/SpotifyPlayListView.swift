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
                        subtitle: product.brand ?? product.category.rawValue,
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
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
                            imageName: item.thumbnail,
                            title: item.title,
                            subtitle: item.brand,
                            onCellPressed: {
                                
                            },
                            onEllipsisPressed: {
                                
                            }
                        )
                        .padding(.leading, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            ZStack {
                Text(product.title)
                    .font(.headline)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(Color.spotifyGray.opacity(0.7))
                    .clipShape(Circle())
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.spotifyWhite)
            .background(showHeader ? Color.blue : Color.clear)
            .animation(.easeInOut(duration: 0.2), value: showHeader)
            .frame(maxHeight: .infinity, alignment: .top)
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
