//
//  SpotifyCategoryCell.swift
//  Components
//
//  Created by beri on 11.09.2026.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    var title: String = "Music"
    var isSelection: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelection ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelection ? .spotifyBlack : .spotifyWhite)
            .cornerRadius(20)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "Title goes here")
            SpotifyCategoryCell(title: "Title goes here", isSelection: true)
            SpotifyCategoryCell(isSelection: true)
        }
    }
}
