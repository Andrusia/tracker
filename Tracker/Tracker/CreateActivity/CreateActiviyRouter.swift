//
//  CreateActiviyRouter.swift
//  Tracker
//
//  Created by Andrei Panasik on 31.01.22.
//

import Foundation
import UIKit

class CreateActivityRouter {
    private weak var view: UIViewController?

    func makeView() -> UIViewController {
        let view = CreateActivityViewController()

        let presenter = CreateActivityPresenter()

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
