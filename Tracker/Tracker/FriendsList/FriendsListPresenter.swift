//
//  FriendsListVIewControllerPresenter.swift
//  Tracker
//
//  Created by Andrei Panasik on 19.01.22.
//

import Foundation

final class FriendsListPresenter: FriendsListPresentable {

    weak var view: FriendsListViewble?

    var router: FriendsListRouter?

    func didLoad() {
        view?.configure(with: makeViewModel())
    }
    
    func didTapAdd() {
        router?.goToUsersListViewController()
    }

    func didTapDeleteFriend(deleteFriend user: User) {

        guard var currentUserChanged = ServiceContainer.shared.userService.currentUser else { return }
        var userChanged = user

        userChanged.friendsId.removeValue(forKey: currentUserChanged.id)
        currentUserChanged.friendsId.removeValue(forKey: user.id)

        let users = ServiceContainer.shared.userService.users().filter() {
            guard $0.id != user.id,
                  $0.id != currentUserChanged.id else { return false }

            return true

        } + [userChanged, currentUserChanged]

        ServiceContainer.shared.userService.login(user: currentUserChanged)
        ServiceContainer.shared.userService.reloadUsers(users: users)
    }

    private func makeViewModel() -> FriendsListModel {
        let users = ServiceContainer.shared.userService.users()

        guard var friendsId = ServiceContainer.shared.userService.currentUser?.friendsId else { return .init(friends: []) }

        let friends: [User] = users.filter() {

            for id in friendsId.values {
                guard $0.id == id else { continue }
                friendsId.removeValue(forKey: id)

                return true
            }

            return false

        }.sorted() { $0.login < $1.login }

        return .init(friends: friends)
    }
}
