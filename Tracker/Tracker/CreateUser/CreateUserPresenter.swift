//
//  CreateUserPresenter.swift
//  Tracker
//
//  Created by Andrei Panasik on 12.04.22.
//

import Foundation

class CreateUserPresenter: CreateUserPresentable {

    weak var view: CreateUserViewble?
    var router: CreateUserRouter?

    private var login: String?
    private var email: String?
    private var password: String?

    func didTapAddUserButton() -> Bool {
        guard let login = login else { return false }
        guard let email = email else { return false }
        guard let password = password else { return false }

        let id = ServiceContainer.shared.userService.users().count + 1
        let newUser = User(id: id, login: login, email: email, password: password)

        ServiceContainer.shared.userService.add(newUser: newUser)

        return true
    }

    func didTapCancel() {
        router?.backToLogin()
    }

    func didValid(string: String, textFieldName: TextFieldName) {
        if string.isEmpty {
            view?.configure(with: ValidModel(textFieldName: textFieldName, validState: .normal))
            return
        }
        if checkValidWithRegex(regex: textFieldName.regex(), string: string) {

            switch textFieldName {
            case .password:
                password = string
            case .login:
                login = string
            case .email:
                email = string
            }
            view?.configure(with: ValidModel(textFieldName: textFieldName, validState: .valid))

        } else {

            switch textFieldName {
            case .password:
                password = nil
            case .login:
                login = nil
            case .email:
                email = nil
            }
            view?.configure(with: ValidModel(textFieldName: textFieldName, validState: .invalid))
        }
    }
}

extension CreateUserPresenter {

    private func checkValidWithRegex(regex: String, string: String, format: String = "SELF MATCHES %@") -> Bool {
        let format = format
        let regex = regex
        guard NSPredicate(format: format, regex).evaluate(with: string) else { return false }

        return true
    }
}
