//
//  ActivityRepository.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation

protocol ActivityRepository {
    func activities() -> [Activity]
    func add(newActivity: Activity)

    func removeAll()
}

