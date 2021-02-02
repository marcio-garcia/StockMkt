//
//  AppDelegate.swift
//  StockMkt
//
//  Created by Marcio Garcia on 02/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        let rootViewController = ViewController()
        navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController?.navigationBar.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

