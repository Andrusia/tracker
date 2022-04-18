//
//  LoginScreenContract.swift
//  Tracker
//
//  Created by Andrei Panasik on 12.02.22.
//

import Foundation

protocol LoginScreenPresentable {
    func didTapLoginButton(login: String?, password: String?)
    func didTapCreateAccountButton()
}
