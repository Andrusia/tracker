//
//  Persistency.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation

protocol Persistency {
    func save<T: Codable>(object: T, for key: String, suite: String) throws
    func object<T: Codable>(for key: String, suite: String) -> T?
    func remove(for key: String, suite: String)
}
