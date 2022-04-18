//
//  TabBarController.swift
//  Tracker
//
//  Created by Andrei Panasik on 19.01.22.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomHeigthTabBar.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()

        viewControllers = makeControllers()
    }

}

extension TabBarController {

    private func makeControllers() -> [UIViewController]{
        let activitiesNavigationController = UINavigationController(rootViewController: ActivityListRouter().makeView())
        let friendsNavigationController = UINavigationController(rootViewController: FriendsListRouter().makeView())

        friendsNavigationController.title = ServiceContainer.shared.userService.currentUser?.login

        return [activitiesNavigationController, friendsNavigationController]
    }

    private func setupTabBar() {
        tabBar.layer.borderWidth = 0.3
    }
}

fileprivate class CustomHeigthTabBar: UITabBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 70

        return sizeThatFits

    }

}

