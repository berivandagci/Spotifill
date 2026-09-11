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
            .themeColor(isSelection: isSelection)
            .cornerRadius(20)
    }
}

extension View {
    func themeColor(isSelection: Bool) -> some View {
        self
            .background(isSelection ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelection ? .spotifyBlack : .spotifyWhite)
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
