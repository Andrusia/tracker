//
//  LoginViewControllerPresenter.swift
//  Tracker
//
//  Created by Andrei Panasik on 16.01.22.
//

import Foundation

final class LoginViewControllerPresenter: LoginScreenPresentable {

    var router: LoginScreenRouter?

    func didTapCreateAccountButton() {
        router?.createAccountScreen()
    }

    func didTapLoginButton(login: String?, password: String?) {
        guard let username = login, !username.isEmpty else { return }
        guard let password = password, !password.isEmpty else { return }

        let users = ServiceContainer.shared.userService.users()

        let existingUser = users.first { $0.login == login }

        if let existingUser = existingUser {
            guard existingUser.password == password else { return }

            ServiceContainer.shared.userService.login(user: existingUser)
            router?.login()
        } else {
            print("none")
        }
    }
}
