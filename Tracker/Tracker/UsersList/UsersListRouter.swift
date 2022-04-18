//
//  UsersListRouter.swift
//  Tracker
//
//  Created by Andrei Panasik on 27.02.22.
//

import Foundation
import UIKit

class UsersListRouter {
  private weak var view: UIViewController?

    func makeView() -> UIViewController {
        let view = UsersListViewController()
        let presenter = UsersListPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = self

        self.view = view

        return view
    }

    func popViewController() {
        view?.navigationController?.popViewController(animated: true)
    }

}
