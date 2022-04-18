//
//  ActivityService.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation

extension ActivityService {
    private struct Parameters {
        static let activitiesKey = "activities"
        static let activitiesSuite = "activities"
    }
}

final class ActivityService: ActivityRepository {

    private let store: Persistency

    private lazy var storedActivities: [Activity] = loadActivities()

    init(persistency: Persistency) {
        store = persistency
    }

    func activities() -> [Activity] {
        return storedActivities
    }

    func add(newActivity: Activity) {
        storedActivities.append(newActivity)
        try? store.save(object: storedActivities, for: Parameters.activitiesKey, suite: Parameters.activitiesSuite)
    }

    func removeAll() {
        store.remove(for: Parameters.activitiesKey, suite: Parameters.activitiesSuite)
        storedActivities = loadActivities()
    }

    private func loadActivities() -> [Activity] {
        return store.object(for: Parameters.activitiesKey, suite: Parameters.activitiesSuite) ?? []
    }
}
