//
//  ServiceContainer.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation

final class ServiceContainer {
    static let shared = ServiceContainer()
    private init() {}

    private let persistency: Persistency = DefaultStore()

    lazy var userService: UsersRepository = UsersService(persistency: persistency)
    lazy var activitiesService: ActivityRepository = ActivityService(persistency: persistency)
}

