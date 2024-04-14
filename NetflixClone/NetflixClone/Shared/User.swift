//
//  User.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double
    
    static var mock: User {
        User(
            id: 3,
            firstName: "John",
            lastName: "Doe",
            age: 33,
            email: "johndoe@email.com",
            phone: "351 666 333 999",
            username: "johndoe",
            password: "123456789",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
