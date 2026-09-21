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
        "This is a sentence about me that will look good on my profile"
    }
    
    static var mock: User {
        User(
            id: 1,
            firstName: "berivan",
            lastName: "dağcı",
            age: 24,
            email: "berivandagcii@x.dummyjson.com",
            phone: "+1 202-555-0143",
            username: "beri",
            password: "password123",
            image: Constants.randomImage,
            height: 172,
            weight: 62.4
        )
    }
}
