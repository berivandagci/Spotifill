//
//  SpotifyReleaseCell.swift
//  Components
//
//  Created by beri on 11.09.2026.
//

import SwiftUI

struct SpotifyReleaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "New release from"
    var subheadline: String? = "Some Artist"
    var title: String? = "Some Playlist"
    var subtitle: String? = "Single • Title"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    if let headline {
                        Text(headline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }
                    if let subheadline {
                        Text(subheadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotifyWhite)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack(spacing: 12) {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 2) {
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .font(.callout)
                                .foregroundStyle(.spotifyWhite)
                                .lineLimit(2)
                        }
                        if let subtitle {
                            Text(subtitle)
                                .font(.callout)
                                .foregroundStyle(.spotifyLightGray)
                                .lineLimit(2)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title2)
                            .background(Color.black.opacity(0.001))
                            .onTapGesture {
                                onAddToPlaylistPressed?()
                            }
                        
                        Spacer()
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title)
                            .background(Color.black.opacity(0.001))
                            .onTapGesture {
                                onPlayPressed?()
                            }
                    }
                }
                .padding(.vertical, 4)
            }
            .frame(height: 140)
        }
        .padding(12)
        .background(Color.spotifyDarkGray)
        .cornerRadius(8)
        .onTapGesture {
            onPlayPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        SpotifyReleaseCell()
            .padding()
    }
}
