//
//  CreateActivityContract.swift
//  Tracker
//
//  Created by Andrei Panasik on 28.01.22.
//

import Foundation

protocol CreateActivityViewble: AnyObject {
    func configure(with viewModel: ExerciseListViewModel)
}

protocol CreateActivityPresentable {
    func didLoad()
    func didTapCreateActivity(exerciseIndex: Int, count: String) -> Bool
    func didTapBack()
}

struct ExerciseListViewModel {
    let exercises: [Exercise]
}
