//
//  UserModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 30/01/2024.
//

import Foundation

struct User {
    var id: String
    var serialNo: Int
    var name: String
    var phoneNo: String
    var about: String
    var email: String
    var password: String
    var online: Bool
    var createdAt: String
    var lastSeen: String
    var updatedAt: String
    var profileUrl: String
    var chats: [String] // You can change the type based on your actual data model
}
