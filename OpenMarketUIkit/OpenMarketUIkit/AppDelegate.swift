//
//  AppDelegate.swift
//  OpenMarketUIkit
//
//  Created by song on 2023/02/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var coordinator: MainCoordinator?
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let navigationController = UINavigationController()
    coordinator = MainCoordinator(navigationController: navigationController)
    coordinator?.start()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    return true
  }
}

