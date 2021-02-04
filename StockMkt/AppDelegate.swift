//
//  AppDelegate.swift
//  StockMkt
//
//  Created by Marcio Garcia on 02/02/21.
//

import UIKit
import Ivorywhite

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let appConfiguration = AppConfiguration.shared

        let baseUrl = "\(appConfiguration.value(for: .httpScheme))://\(appConfiguration.value(for: .baseUrl))"
        let networkConfiguration = NetworkConfiguration(baseUrl: baseUrl,
                                                        apiToken: appConfiguration.value(for: .apiToken))
        let environment = appConfiguration.environment
        networkConfiguration.setEnvironment(from: environment)
        if environment != .production {
            networkConfiguration.debugMode = true
        }

        let ivorywhite = Ivorywhite.shared.service(debugMode: networkConfiguration.debugMode)
        let networkService = StockNerworkService(apiConfiguration: networkConfiguration, networkService: ivorywhite)
        let rootViewController = HistoryBuilder(api: networkService).build()
        navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController?.navigationBar.backgroundColor = .white
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

