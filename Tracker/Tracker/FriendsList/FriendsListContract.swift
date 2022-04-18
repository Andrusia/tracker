//
//  FriendsListContract.swift
//  Tracker
//
//  Created by Andrei Panasik on 28.02.22.
//

import Foundation

protocol FriendsListViewble: AnyObject {
    func configure(with viewModel: FriendsListModel)
}

protocol FriendsListPresentable {
    func didLoad()

    func didTapAdd()
    func didTapDeleteFriend(deleteFriend user: User)
}

struct FriendsListModel {
    let friends: [User]
}
