//
//  PlaylistDescriptionCell.swift
//  Components
//
//  Created by beri on 14.09.2026.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriotionText: String = Product.mock.description
    var userName: String = "Rick"
    var subheadline: String = "Some headline goes here"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onSharedPressed: (() -> Void)? = nil
    var onDownLoadPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
                                  
    var body: some View {
        VStack(alignment: .leading, spacing: 8)
        {
            Text(descriotionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(minWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
Image(systemName: "applelogo")
                    .font(.title3)
                    .foregroundStyle(.spotifyGreen)
                Text("Made for")
                Text(userName)
                    .bold()
                    .foregroundStyle(.spotifyWhite)
                
        }    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        PlaylistDescriptionCell()
            .padding()
    }
    
}
