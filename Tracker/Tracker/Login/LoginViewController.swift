//
//  ViewControllerLogin.swift
//  Tracker
//
//  Created by Andrei Panasik on 7.01.22.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {

    var presenter: LoginScreenPresentable?
    private let loginButton = UIButton()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let createUserButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension LoginViewController {
   private func setupUI() {
        view.backgroundColor = .white

        let actionButton = UIAction.init(handler: { _ in self.tapLoginButton() })
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.addAction(actionButton, for: .touchUpInside)
        loginButton.layer.borderWidth = 0.3
        loginButton.layer.cornerRadius = 10
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.setTitleColor(.systemGray5, for: .highlighted)

        loginTextField.layer.borderWidth = 0.3
        loginTextField.placeholder = " Username"
        loginTextField.font = .systemFont(ofSize: 22)
        loginTextField.autocorrectionType = .no

        passwordTextField.layer.borderWidth = 0.3
        passwordTextField.placeholder = " Password"
        passwordTextField.font = .systemFont(ofSize: 22)
        passwordTextField.isSecureTextEntry = true

       createUserButton.setTitle("Create an account", for: .normal)
       createUserButton.setTitleColor(.systemBlue, for: .normal)
       createUserButton.addAction(UIAction() { _ in self.tapCreateButton() }, for: .touchUpInside)
       

        view.addSubview(passwordTextField)
        view.addSubview(loginTextField)
        view.addSubview(loginButton)
        view.addSubview(createUserButton)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
       createUserButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.rightAnchor.constraint(equalTo: loginTextField.leftAnchor, constant: 300),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: passwordTextField.leftAnchor, constant: 300),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.rightAnchor.constraint(equalTo: loginButton.leftAnchor, constant: 100),

            createUserButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            createUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

   private func tapLoginButton() {
        view.endEditing(true)

        presenter?.didTapLoginButton(login: loginTextField.text , password: passwordTextField.text)
    }

    private func tapCreateButton() {
        loginTextField.text = nil
        passwordTextField.text = nil
        presenter?.didTapCreateAccountButton()
    }
}
