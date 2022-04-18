//
//  Users.swift
//  Tracker
//
//  Created by Andrei Panasik on 16.01.22.
//

import Foundation

struct Users {

    static var currentUser: String {
        get {
            guard let login = UserDefaults.standard.string(forKey: "login") else { return "" }
            return login
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "login")
        }
    }

    static var users: [String:User] = [
        "Andrusia": .init(name: "Andrey", password: 123, login: "Andrusia"),
        "Vitalik": .init(name: "Vitalik", password: 456, login: "Vitalik")
    ]

    static var currenUsername: String {
        return users[currentUser]?.name ?? ""
    }
}
