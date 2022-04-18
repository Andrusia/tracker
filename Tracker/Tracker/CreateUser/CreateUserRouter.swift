//
//  CreateUserRouter.swift
//  Tracker
//
//  Created by Andrei Panasik on 12.04.22.
//

import Foundation
import UIKit

class CreateUserRouter {

  private weak var view: UIViewController?

    func makeView() -> UIViewController {
        let view = CreateUserViewController()
        let presenter = CreateUserPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = self

        self.view = view 

        return view
    }

    func backToLogin() {
        view?.dismiss(animated: true)
    }
    
}
