//
//  CreateUserViewController.swift
//  Tracker
//
//  Created by Andrei Panasik on 11.04.22.
//

import Foundation
import UIKit

class CreateUserViewController: UIViewController, CreateUserViewble {
    var presenter: CreateUserPresentable?

    private var stackView: UIStackView!

    private let loginTextField = UITextField()
    private let loginLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordLabel = UILabel()
    private let emailTextField = UITextField()
    private let emailLabel = UILabel()
    private let createUserButton = UIButton()

    private var validModel: ValidModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }

    func configure(with model: ValidModel) {
        validModel = model

        updateView()
    }
}



extension CreateUserViewController {
    private func tapCreateUserButton() {
        guard let success = presenter?.didTapAddUserButton(), success else { return }

        setupUITextField()
        setupUILabel()

        present(makeSuccessAlert(), animated: true)
    }

    private func tapCancelButton() {
        presenter?.didTapCancel()
    }

    private func updateView() {
        switch validModel.textFieldName {
        case .password:
            updateViewState(textField: passwordTextField, label: passwordLabel)
        case .login:
            updateViewState(textField: loginTextField, label: loginLabel)
        case .email:
            updateViewState(textField: emailTextField, label: emailLabel)
        }
    }

    private func updateViewState(textField: UITextField, label: UILabel) {
        switch validModel.validState {

        case .normal:

            textField.layer.borderColor = UIColor.systemGray.cgColor
            label.isHidden = true

        case .valid:

            textField.layer.borderColor = UIColor.systemGreen.cgColor
            label.textColor = .systemGreen
            label.text = "success"
            label.isHidden = false

        case .invalid:

            textField.layer.borderColor = UIColor.systemRed.cgColor
            label.textColor = .systemRed
            label.text = validModel.textFieldName.requirementsMessage()
            label.isHidden = false
        }
    }
}

extension CreateUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return  }
        switch textField {
        case loginTextField:
            presenter?.didValid(string: text, textFieldName: .login)
        case emailTextField:
            presenter?.didValid(string: text, textFieldName: .email)
        case passwordTextField:
            presenter?.didValid(string: text, textFieldName: .password)
        default:
            break
        }
    }
}

extension CreateUserViewController {

    private func makeSuccessAlert() -> UIAlertController {
        let alert = UIAlertController(title: "success", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel) { _ in self.tapCancelButton() }

        alert.addAction(action)

        return alert
    }

    private func setupUITextField() {
        loginTextField.placeholder = " login"
        loginTextField.setupUI()
        loginTextField.delegate = self

        emailTextField.placeholder = " email"
        emailTextField.setupUI()
        emailTextField.delegate = self

        passwordTextField.placeholder = " password"
        passwordTextField.setupUI()
        passwordTextField.delegate = self
    }

    private func setupUILabel() {
        loginLabel.setupUI()

        emailLabel.setupUI()

        passwordLabel.setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Create"

        setupUITextField()

        setupUILabel()

        createUserButton.backgroundColor = .systemBlue
        createUserButton.layer.cornerRadius = 8
        createUserButton.setTitle("Create", for: .normal)
        createUserButton.addAction(UIAction() { _ in self.tapCreateUserButton() }, for: .touchUpInside)

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView = UIStackView(arrangedSubviews: [
            loginTextField,
            loginLabel,
            emailTextField,
            emailLabel,
            passwordTextField,
            passwordLabel,
            createUserButton
        ])

        navigationItem.setLeftBarButton(.init(systemItem: .cancel,
                                              primaryAction: UIAction() { _ in self.tapCancelButton() },
                                              menu: nil),
                                        animated: true)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ])
    }
}

private extension UITextField {
    func setupUI() {
        layer.borderWidth = 0.3
        font = .systemFont(ofSize: 22)
        autocorrectionType = .no
        text = ""
        layer.borderColor = UIColor.systemGray.cgColor
    }
}

private extension UILabel {
    func setupUI() {
        font = .systemFont(ofSize: 14)
        isHidden = true
        sizeToFit()
    }
}
