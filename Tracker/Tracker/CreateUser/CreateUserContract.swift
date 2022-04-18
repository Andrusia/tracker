//
//  File.swift
//  Tracker
//
//  Created by Andrei Panasik on 12.04.22.
//

import Foundation

protocol CreateUserViewble: AnyObject {
    func configure(with model: ValidModel)
}

protocol CreateUserPresentable {
    func didTapAddUserButton() -> Bool
    func didTapCancel()

    func didValid(string: String, textFieldName: TextFieldName)
}

struct ValidModel {
    let textFieldName: TextFieldName
    let validState: ValidState
}

enum ValidState {
    case normal
    case invalid
    case valid
}

enum TextFieldName {
    case password
    case login
    case email

    func regex() -> String {
        switch self {
        case .password:
            return "(?=.*[0-9].*[0-9])(?=.*[a-z]).{4,10}"
        case .login:
            return "[a-zA-Z]{4,10}"
        case .email:
            return "[a-zA-Z0-9._]{4,15}+@[a-z]{2,10}+\\.[a-z]{2,5}"
        }
    }

    func requirementsMessage() -> String {
        switch self {
        case .password:
            return "Ensure string is of length 8 and has two digits"
        case .login:
            return "Must be a 4-10 characters (a-z,A-Z)"
        case .email:
            return "Enter a valid email adress"
        }
    }
}

