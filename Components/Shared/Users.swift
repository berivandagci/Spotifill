//
//  Users.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
    
    static var mock: UserArray {
        UserArray(users: [User.mock], total: 1, skip: 0, limit: 10)
    }
}

struct UserInterest: Codable, Identifiable {
    let id = UUID().uuidString
    var iconName: String? = nil
    var emoji: String? = nil
    var text: String
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double
    
    var work: String {
        "Worker as Some Job"
    }
    
    var education: String {
        "Graduate Degree"
    }
    
    var aboutMe: String {
        "This is a sentence about me that will look good on my profile!"
    }
    
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: education),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Virgo")
        ]
    }
    
    var interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "🍕", text: "Foodie"),
            UserInterest(iconName: nil, emoji: "✈️", text: "Travel"),
            UserInterest(iconName: nil, emoji: "🏋️‍♂️", text: "Gym"),
            UserInterest(iconName: nil, emoji: "🎧", text: "Music")
        ]
    }
    var images: [String] {
        ["https://picsum.photos/600/600", "https://picsum.photos/600/600", "https://picsum.photos/600/600"]
    }
    
    static var mock: User {
        User(
            id: 444,
            firstName: "Berivan",
            lastName: "Dağcı",
            age: 76,
            email: "beri@x.dummyjson.com",
            phone: "+1 202-555-0143",
            username: "beri",
            password: "password123",
            image: Constants.randomImage,
            height: 165,
            weight: 52.4
        )
    }
}
