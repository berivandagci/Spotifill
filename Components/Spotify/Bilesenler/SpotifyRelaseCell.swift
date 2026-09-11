//
//  SpotifyRelaseCell.swift
//  Components
//
//  Created by beri on 11.09.2026.
//

import SwiftUI

struct SpotifyRelaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "New realase from"
    var subheadline: String? = "Some Artist"
    var title: String? = "Some Platylist"
    var subtitle: String? = "Single- title"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onPlayPresed: (() -> Void)? = nil
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2 ) {
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
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                VStack(alignment: .leading, spacing: 2)  {
                    if let title {
                        
                        Text(title)
                            .fontWeight(.semibold)
                            .font(.callout)
                            .foregroundStyle(.spotifyWhite)
                    }
                    if let subtitle {
                        Text(subtitle)
                            .foregroundStyle(.spotifyLightGray)
                    }
                }
                .font(.callout)
                HStack {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.spotifyLightGray)
                        .font(.title)
                        .background(Color.black.opacity(0.001))
                        .padding(4)
                        .onTapGesture {
                            onAddToPlaylistPressed?()
                            
                        }
                        .offset(x: -4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(.spotifyWhite)
                        .font(.title)
                        
                }
            }
            
        }
        .themeColor(isSelection: false)
        .cornerRadius(0)
        .onTapGesture {
            
            onPlayPresed?()
        }
        
    }
}


#Preview {
    SpotifyRelaseCell()
        SpotifyRelaseCell()
        .padding()
}
