//
//  SpotifyRecentlyCell.swift
//  Components
//
//  Created by beri on 11.09.2026.
//

import SwiftUI

struct SpotifyRecentlyCell: View {
    var imageName: String = Constants.randomImage
    var title: String = "Some random title"
    var body: some View {
        HStack(spacing: 16) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.spotifyWhite)
                .lineLimit(2)
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.spotifyDarkGray)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        VStack {
            HStack {
                SpotifyRecentlyCell()
                SpotifyRecentlyCell()
            }
            HStack {
                SpotifyRecentlyCell()
                SpotifyRecentlyCell()
            }
        }
        .padding()
    }
}
