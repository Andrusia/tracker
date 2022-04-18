//
//  ActivityListRouter.swift
//  Tracker
//
//  Created by Andrei Panasik on 22.01.22.
//

import Foundation
import UIKit

final class ActivityListRouter {
    private weak var view: UIViewController?

    func makeView() -> UIViewController {
        let view = ActivityListViewController()

        let presenter = ActivityListPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = self

        self.view = view

        return view
    }

    func logout() {
        view?.view.window?.rootViewController = LoginScreenRouter().makeView()
    }
    
    func goToCreateViewController() {
        view?.navigationController?.pushViewController(CreateActivityRouter().makeView(), animated: true)
    }
}
