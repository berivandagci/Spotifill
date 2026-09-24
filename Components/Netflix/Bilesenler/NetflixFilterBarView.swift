//
//  NetflixFilterBarView.swift
//  Components
//
//  Created by beri on 24.09.2026.
//

import SwiftUI

struct NetflixFilterBarView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
               
                Image(systemName: "xmark")
                    .padding(8)
                    .background(
                        Circle()
                            .stroke(lineWidth: 1)
                    )
                    .foregroundStyle(.netflixLightGray)
                
              
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixFilterBarView()
    }
}
