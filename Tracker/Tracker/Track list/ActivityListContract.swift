//
//  ActivityListContract.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation
import UIKit

protocol ActivityListViewable: AnyObject {
    func configure(with viewModel: ActivityListViewModel)
}

protocol ActivityListPresentable {
    func viewDidLoad()

    func didTapAddActivity()
    func didTapRemoveAll()
    func didTapLogout()
}

struct ActivityListViewModel {
    let sections: [Section]
}

extension ActivityListViewModel {
    struct Section {
        let name: String
        let activities: [Activity]
    }
}
