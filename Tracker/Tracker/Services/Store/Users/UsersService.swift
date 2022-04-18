//
//  UsersService.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation

extension UsersService {
    private struct Parameters {
        static let usersSuite = "users"
        static let usersKey = "users"
        static let currentUsersKey = "currentUsers"
    }
}

final class UsersService: UsersRepository {

    private let store: Persistency
    private lazy var storedUsers: [User] = loadUsers()

    private(set) lazy var currentUser: User? = {
        return store.object(for: UsersService.Parameters.currentUsersKey, suite: UsersService.Parameters.usersSuite)
    }()

    init(persistency: Persistency) {
        store = persistency
    }

    func users() -> [User] {
        return storedUsers
    }

    func add(newUser: User) {
        storedUsers.append(newUser)
        try? store.save(object: storedUsers, for: Parameters.usersKey, suite: Parameters.usersSuite)
    }

    func login(user: User) {
        currentUser = user
        try? store.save(object: user, for: Parameters.currentUsersKey, suite: Parameters.usersSuite)
    }

    func logout() {
        currentUser = nil
        store.remove(for: Parameters.currentUsersKey, suite: Parameters.usersSuite)
    }

    func reloadUsers(users: [User]) {
        storedUsers = users
        try? store.save(object: users, for: Parameters.usersKey, suite: Parameters.usersSuite)

    }

    private func loadUsers() -> [User] {
        return store.object(for: Parameters.usersKey, suite: Parameters.usersSuite) ?? []
    }
}
