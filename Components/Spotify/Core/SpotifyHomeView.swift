//
//  SpotifyHomeView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: SpotifyCategory? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(0..<20, id: \.self) { _ in
                            Rectangle()
                                .frame(width: 200, height: 200)
                        }
                    } header: {
                        header
                    }
                }
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            let users = try await DatabaseHelper().getUsers()
            currentUser = users.first
        } catch {
            print("Veri çekerken hata oluştu: \(error)")
        }
    }
    
    private var header: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    if let currentUser {
                        ImageLoaderView(urlString: currentUser.image)
                            .frame(width: 30, height: 30)
                            .background(.spotifyWhite)
                            .clipShape(Circle())
                            .onTapGesture {
                                
                            }
                    }
                    
                    ForEach(SpotifyCategory.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelection: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 8)
        .background(Color.spotifyBlack)
    }
}

#Preview {
    SpotifyHomeView()
}
