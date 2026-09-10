//
//  SpotifyHomeView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    ImageLoaderView(urlString: currentUser?.image ?? "")
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            
                        }
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
            }
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        do {
            let users = try await DatabaseHelper().getUsers()
            currentUser = users.first
        } catch {
            print("Veri çekerken hata oluştu: \(error)")
        }
    }
}

#Preview {
    SpotifyHomeView()
}
