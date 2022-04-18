//
//  DefaultStore.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation

extension DefaultStore {
    enum StoreError: Error {
        case failedSuite
    }
}

final class DefaultStore: Persistency {
    func remove(for key: String, suite: String) {
        guard let userDefaults = UserDefaults(suiteName: suite),
              userDefaults.object(forKey: key) != nil else { return }
        
        userDefaults.removeObject(forKey: key)
    }

    func save<T: Codable>(object: T, for key: String, suite: String) throws {
        guard let userDefaults = UserDefaults(suiteName: suite) else {
            throw StoreError.failedSuite
        }

        let data = try JSONEncoder().encode(object)
        userDefaults.set(data, forKey: key)
    }

    func object<T: Codable>(for key: String, suite: String) -> T? {
        guard let userDefaults = UserDefaults(suiteName: suite),
              let data = userDefaults.data(forKey: key) else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }
}
