//
//  UsersListContract.swift
//  Tracker
//
//  Created by Andrei Panasik on 18.02.22.
//

import Foundation

protocol UsersListPresentable {
    func didLoad()

    func didTapBack()
    func didTapAddFriendToList(newFriend: User)
}

protocol UsersListViewable: AnyObject {
    func configure(with viewModel: UsersListViewModel)
}

struct UsersListViewModel {
    let sections: [Section]
}

extension UsersListViewModel {
    struct Section {
        let users: [User]
        let name: String?
    }
}
