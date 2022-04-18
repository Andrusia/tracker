//
//  LoginScreenRouter.swift
//  Tracker
//
//  Created by Andrei Panasik on 13.02.22.
//

import Foundation
import UIKit

final class LoginScreenRouter {
    private weak var view: UIViewController?

    func makeView() -> UIViewController {
        let view = LoginViewController()

        let presenter = LoginViewControllerPresenter()

        presenter.router = self
        view.presenter = presenter

        self.view = view
        
        return view
    }

    func createAccountScreen() {
        let navigation = UINavigationController(rootViewController: CreateUserRouter().makeView())
        view?.present(navigation, animated: true)
    }
    func login() {
        view?.view.window?.rootViewController = TabBarController()
    }
}
