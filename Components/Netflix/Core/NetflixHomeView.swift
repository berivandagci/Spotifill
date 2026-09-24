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
            VStack(spacing: 8) {
                header // Düzeltildi: Doğru değişken ismi çağrıldı
                    .padding(.horizontal, 16)
                Spacer()
            }
        }
        .foregroundStyle(.netflixWhite)
    }
    
    private var header: some View { // Düzeltildi: 'headeer' yerine 'header' yapıldı
        HStack(spacing: 8) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        // Televizyon/yayın ikonuna basıldığında yapılacak işlemler
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        // Arama ikonuna basıldığında yapılacak işlemler
                    }
            }
            .font(.title)
        }
        .padding(.horizontal, 16) // Kenarlardan daha şık durması için hafif bir boşluk eklenebilir
    }
}

#Preview {
    NetflixHomeView()
}
