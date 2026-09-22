//
//  BumbleHomeView.swift
//  Components
//
//  Created by beri on 21.09.2026.
//

import SwiftUI
import SwiftfulUI

struct BumbleHomeView: View {
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    
    private let filters: [String] = ["Everyone", "Trending", "Hello"]
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack(spacing: 12) {
                header
                 
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom
                    )
              
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            let isPrevious = (selectedIndex - 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                Rectangle()
                                    .fill(Color.red)
                                    .overlay(
                                        Text("\(index)")
                                            .font(.largeTitle)
                                            .foregroundStyle(.white)
                                    )
                                    .zIndex(Double(allUsers.count - index))
                                    .withDragGesture(
                                        onChanged: { offset in
                                            // Sürükleme sırasında yapılacak işlemler
                                        },
                                        onEnded: { offset in
                                            // Sürükleme bittiğinde kartı geçme mantığı
                                            if abs(offset.width) > 100 {
                                                selectedIndex += 1
                                            }
                                        }
                                    )
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .padding(8)
            .task {
                await getData()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func getData() async {
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            print("Kullanıcılar çekilirken hata oluştu: \(error)")
            allUsers = [.mock]
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                       
                    }
                 
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                       
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
             
            Spacer()
             
            Text("bumble")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .leading)
             
            Spacer()
             
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                   
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

#Preview {
    BumbleHomeView()
}
