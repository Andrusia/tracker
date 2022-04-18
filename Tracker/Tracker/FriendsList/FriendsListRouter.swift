//
//  FriendsListRouter.swift
//  Tracker
//
//  Created by Andrei Panasik on 1.03.22.
//

import Foundation
import UIKit


class FriendsListRouter {
   private weak var view: FriendsListViewController?

    func makeView() -> UIViewController {
        let view = FriendsListViewController()
        let presenter = FriendsListPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = self

        self.view = view

        return view
    }

    func goToUsersListViewController() {
        view?.navigationController?.pushViewController(UsersListRouter().makeView(), animated: true)
    }
}
