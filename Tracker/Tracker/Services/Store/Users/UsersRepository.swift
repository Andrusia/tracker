//
//  UsersRepository.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation

protocol UsersRepository {
    var currentUser: User? { get }

    func users() -> [User]

    func add(newUser: User)
    func login(user: User)
    func logout()
    func reloadUsers(users: [User])
}
