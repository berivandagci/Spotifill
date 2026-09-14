//
//  SpotifyPlayListView.swift
//  Components
//
//  Created by beri on 14.09.2026.
//

import SwiftUI

struct SpotifyPlayListView: View {
    var product: Product
    
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
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SpotifyPlayListView(product: .mock)
}
