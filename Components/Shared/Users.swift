//
//  Users.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import Foundation
// MARK: - User Welcome
struct UserWelcome: Codable {
    let users: [User]
    let total: Int
    let skip: Int
    let limit: Int

    enum CodingKeys: String, CodingKey {
        case users = "users"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let maidenName: String
    let age: Int
    let gender: Gender
    let email: String
    let phone: String
    let username: String
    let password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height: Double
    let weight: Double
    let eyeColor: String
    let hair: Hair
    let ip: String
    let address: Address
    let macAddress: String
    let university: String
    let bank: Bank
    let company: Company
    let ein: String
    let ssn: String
    let userAgent: String
    let crypto: Crypto
    let role: Role

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case maidenName = "maidenName"
        case age = "age"
        case gender = "gender"
        case email = "email"
        case phone = "phone"
        case username = "username"
        case password = "password"
        case birthDate = "birthDate"
        case image = "image"
        case bloodGroup = "bloodGroup"
        case height = "height"
        case weight = "weight"
        case eyeColor = "eyeColor"
        case hair = "hair"
        case ip = "ip"
        case address = "address"
        case macAddress = "macAddress"
        case university = "university"
        case bank = "bank"
        case company = "company"
        case ein = "ein"
        case ssn = "ssn"
        case userAgent = "userAgent"
        case crypto = "crypto"
        case role = "role"
    }
}

// MARK: - Address
struct Address: Codable {
    let address: String
    let city: String
    let state: String
    let stateCode: String
    let postalCode: String
    let coordinates: Coordinates
    let country: Country

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case city = "city"
        case state = "state"
        case stateCode = "stateCode"
        case postalCode = "postalCode"
        case coordinates = "coordinates"
        case country = "country"
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lat: Double
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

// MARK: - Bank
struct Bank: Codable {
    let cardExpire: String
    let cardNumber: String
    let cardType: String
    let currency: String
    let iban: String

    enum CodingKeys: String, CodingKey {
        case cardExpire = "cardExpire"
        case cardNumber = "cardNumber"
        case cardType = "cardType"
        case currency = "currency"
        case iban = "iban"
    }
}

// MARK: - Company
struct Company: Codable {
    let department: String
    let name: String
    let title: String
    let address: Address

    enum CodingKeys: String, CodingKey {
        case department = "department"
        case name = "name"
        case title = "title"
        case address = "address"
    }
}

// MARK: - Crypto
struct Crypto: Codable {
    let coin: Coin
    let wallet: Wallet
    let network: Network

    enum CodingKeys: String, CodingKey {
        case coin = "coin"
        case wallet = "wallet"
        case network = "network"
    }
}

enum Coin: String, CodingKey, Codable {
    case bitcoin = "Bitcoin"
}

enum Network: String, Codable {
    case ethereumERC20 = "Ethereum (ERC20)"
}

enum Wallet: String, Codable {
    case the0Xb9Fc2Fe63B2A6C003F1C324C3Bfa53259162181A = "0xb9fc2fe63b2a6c003f1c324c3bfa53259162181a"
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

// MARK: - Hair
struct Hair: Codable {
    let color: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case type = "type"
    }
}

enum TypeEnum: String, Codable {
    case curly = "Curly"
    case kinky = "Kinky"
    case straight = "Straight"
    case wavy = "Wavy"
}

enum Role: String, Codable {
    case admin = "admin"
    case moderator = "moderator"
    case user = "user"
}
