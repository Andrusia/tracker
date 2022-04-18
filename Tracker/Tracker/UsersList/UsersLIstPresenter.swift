//
//  UsersLIstVIewControllerPresenter.swift
//  Tracker
//
//  Created by Andrei Panasik on 19.01.22.
//

import Foundation
import UIKit

class UsersListPresenter: UsersListPresentable {

    weak var view: UsersListViewable?
    var router: UsersListRouter?

    func didLoad() {
        view?.configure(with: makeViewModel())
    }

    func didTapAddFriendToList(newFriend: User) {
        guard let currentUser = ServiceContainer.shared.userService.currentUser else { fatalError() }

        var friendlyUserChanged = newFriend
        var currentUserChanged = currentUser

        friendlyUserChanged.friendsId[currentUser.id] = currentUser.id
        currentUserChanged.friendsId[newFriend.id] = newFriend.id

        let usersChanged = ServiceContainer.shared.userService.users().filter() {
            guard $0.id != currentUser.id else { return false }
            guard $0.id != newFriend.id else { return false }

            return true
        } + [friendlyUserChanged, currentUserChanged]

        ServiceContainer.shared.userService.reloadUsers(users: usersChanged)
        ServiceContainer.shared.userService.login(user: currentUserChanged)
    }

    func didTapBack() {
        router?.popViewController()
    }

    private func makeViewModel() -> UsersListViewModel {
        guard let currentUser = ServiceContainer.shared.userService.currentUser else { fatalError() }

        let usersList = ServiceContainer.shared.userService.users().filter() {

            guard currentUser.friendsId[$0.id] == nil,
                  currentUser.id != $0.id else { return false }

            return true

        }.sorted() { $0.login < $1.login }

        let section = UsersListViewModel.Section(users: usersList, name: nil)

        return UsersListViewModel(sections: [section])
    }
}
