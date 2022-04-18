//
//  AppDelegate.swift
//  Tracker
//
//  Created by Andrei Panasik on 12.12.21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

       print( NSHomeDirectory())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if ServiceContainer.shared.userService.currentUser == nil {
            window?.rootViewController = LoginScreenRouter().makeView()
        } else {
            window?.rootViewController = TabBarController()
        }
        window?.makeKeyAndVisible()
        
        return true
    }
}

