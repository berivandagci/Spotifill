//
//  NetflixHomeView.swift
//  Components
//
//  Created by beri on 24.09.2026.
//

import SwiftUI

struct NetflixHomeView: View {
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            VStack(spacing: 8){
                HStack(spacing : 8) {
                    Text("For You")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                    HStack(spacing: 16) {
                        Image(systemName: "tv.badge.wifi")
                        
                        Image(systemName: "magnifyingglass")
                        
                    }
                    .font(.title)
                    
                }
            }
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    NetflixHomeView()
}
