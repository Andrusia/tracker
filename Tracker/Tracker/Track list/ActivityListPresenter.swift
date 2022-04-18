//
//  ActivityListPresenter.swift
//  Tracker
//
//  Created by Andrei Panasik on 12.12.21.
//

import Foundation

final class ActivityListPresenter: ActivityListPresentable {

    weak var view: ActivityListViewable?
    var router: ActivityListRouter?

    func viewDidLoad() {
        view?.configure(with: makeViewModel())
    }

    func didTapAddActivity() {
        router?.goToCreateViewController()
    }

    func didTapRemoveAll() {
        ServiceContainer.shared.activitiesService.removeAll()
        view?.configure(with: makeViewModel())
    }

    func didTapLogout() {
        ServiceContainer.shared.userService.logout()
        router?.logout()
    }

    private func makeViewModel() -> ActivityListViewModel {
        guard let currentUserId = ServiceContainer.shared.userService.currentUser?.id else { fatalError() }

        let activities = ServiceContainer.shared.activitiesService.activities().filter() { $0.userId == currentUserId }

        let dictionary: [String: [Activity]] = [:]
        let sections = activities.reduce(into: dictionary) { result, activity in
            if result[activity.currentDay] != nil {
                result[activity.currentDay]?.append(activity)
            } else {
                result[activity.currentDay] = [activity]
            }
        }.map { ActivityListViewModel.Section(name: $0.key, activities: $0.value) }.sorted() { $0.name > $1.name }

        return .init(sections: sections)
    }
}
