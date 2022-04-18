//
//  CreateExercisePresenter.swift
//  Tracker
//
//  Created by Andrei Panasik on 18.12.21.
//

import Foundation

final class CreateActivityPresenter: CreateActivityPresentable {

    weak var view: CreateActivityViewble?

    var router: CreateActivityRouter?

    func didLoad() {
        view?.configure(with: makeViewModel())
    }

    func didTapBack() {
        router?.popViewController()
    }

    func didTapCreateActivity(exerciseIndex: Int, count: String) -> Bool {
        guard let intAmount = Int(count), intAmount < 1000, intAmount != 0 else { return false }
        let exercise = Exercise.allCases[exerciseIndex]
        guard let userId = ServiceContainer.shared.userService.currentUser?.id else { return false }

        let activity = Activity(userId: userId, exercise: exercise, amount: intAmount, date: Date())
        ServiceContainer.shared.activitiesService.add(newActivity: activity)

        return true
    }

    private  func makeViewModel() -> ExerciseListViewModel {
        let exercise = Exercise.allCases
        return .init(exercises: exercise)
    }
}
