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
    @State private var cardOffsets: [String: Bool] = [:] // ID'leri String veya UUID tutmak çakışmaları önler
    private let filters: [String] = ["Everyone", "Trending", "Hello"]
    @State private var currentSwipeoffset: CGFloat = 0
    
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
                        // Index yerine kullanıcı ID'si veya elemanın kendisi üzerinden dönmek daha güvenlidir
                        ForEach(Array(allUsers.enumerated()), id: \.element.id) { (index, user) in
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
                    
                    overlaySwipingIndicator
                        .zIndex(999999)
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
        guard index < allUsers.count else { return }
        let user = allUsers[index]
        cardOffsets[String(user.id)] = isLike
        selectedIndex += 1
        currentSwipeoffset = 0
    }
    
    @ViewBuilder
    private func cardView(for user: User, index: Int) -> some View {
        let offsetValue = cardOffsets[String(user.id)]
        let xOffset: CGFloat = offsetValue == nil ? 0 : (offsetValue == true ? 900 : -900)
         
        userProfileCell(for: user, index: index)
            .zIndex(Double(allUsers.count - index))
            .offset(x: xOffset)
    }
    
    @ViewBuilder
    private func userProfileCell(for user: User, index: Int) -> some View {
        BumbleCardView(user: user)
            .withDragGesture(
                .horizontal,
                resets: true,
                rotationMultiplier: 1.05,
                onChanged: { dragOffset in
                    currentSwipeoffset = dragOffset.width
                },
                onEnded: { dragOffset in
                    currentSwipeoffset = 0
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
            let users = try await DatabaseHelper().getUsers()
            if users.isEmpty {
                // Farklı resimlerin ve verilerin gelmesi için mock verileri çeşitlendiriyoruz
                allUsers = [
                    User.mock,
                    User.mock,
                    User.mock,
                    User.mock
                ]
            } else {
                allUsers = users
            }
        } catch {
            print("Kullanıcılar çekilirken hata oluştu: \(error)")
            allUsers = [
                User.mock,
                User.mock,
                User.mock,
                User.mock
            ]
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture { }
                 
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture { }
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
                .onTapGesture { }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
    
    @ViewBuilder
    private var overlaySwipingIndicator: some View {
        ZStack {
            Circle()
                .fill(currentSwipeoffset < -20 ? Color.red.opacity(0.8) : Color.gray.opacity(0.4))
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(currentSwipeoffset < -50 ? 1.3 : 1.0)
                .opacity(currentSwipeoffset < 0 ? 1.0 : 0.0)
                .offset(x: 40)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .fill(currentSwipeoffset > 20 ? Color.green.opacity(0.8) : Color.gray.opacity(0.4))
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(currentSwipeoffset > 50 ? 1.3 : 1.0)
                .opacity(currentSwipeoffset > 0 ? 1.0 : 0.0)
                .offset(x: -40)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    BumbleHomeView()
}
