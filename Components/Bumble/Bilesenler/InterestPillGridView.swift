//
//  InterestPillGridView.swift
//  Components
//
//  Created by beri on 21.09.2026.
//

import SwiftUI
import SwiftfulUI

struct InterestPillGridView: View {
    var interests: [UserInterest] = User.mock.interests
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            ForEach(interests) { interest in
                InterestPillView(
                    iconName: interest.iconName,
                    emoji: interest.emoji,
                    text: interest.text
                )
            }
        }
    }
}

#Preview {
    InterestPillGridView(interests: User.mock.interests)
        .padding()
}
