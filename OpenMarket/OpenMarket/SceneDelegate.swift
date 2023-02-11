//
//  SceneDelegate.swift
//  OpenMarket
//
//  Created by song on 2023/02/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var mainCoordinator : MainCoordinator?
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    
    let rootNavigationController = UINavigationController()
    window?.rootViewController = rootNavigationController
    window?.makeKeyAndVisible()
    
    mainCoordinator = MainCoordinator(navigationController: rootNavigationController)
    mainCoordinator?.start()
  }
}
