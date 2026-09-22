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
    @State private var cardOffsets: [Int: Bool] = [:]
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
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                cardView(for: user, index: index)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxHeight: .infinity)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
            .task {
                await getData()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        selectedIndex += 1
    }
    
    @ViewBuilder
    private func cardView(for user: User, index: Int) -> some View {
        let offsetValue = cardOffsets[user.id]
        let xOffset: CGFloat = offsetValue == nil ? 0 : (offsetValue == true ? 900 : -900)
         
        userProfileCell(for: user, index: index)
            .zIndex(Double(allUsers.count - index))
            .offset(x: xOffset)
    }
    
    @ViewBuilder
    private func userProfileCell(for user: User, index: Int) -> some View {
        let offsetValue = cardOffsets[user.id]
        
        Rectangle()
            .fill(offsetValue == true ? Color.green : (offsetValue == false ? Color.red : Color.blue))
            .overlay(
                Text("\(index)")
            )
            .withDragGesture(
                .horizontal,
                resets: true,
                rotationMultiplier: 1.05,
                onChanged: { offset in
                    // Sürükleme anındaki işlemler
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -50 {
                        userDidSelect(index: index, isLike: false)
                    } else if dragOffset.width > 50 {
                        userDidSelect(index: index, isLike: true)
                    }
                }
            )
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
