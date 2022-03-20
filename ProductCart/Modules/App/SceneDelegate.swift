//
//  SceneDelegate.swift
//  ProductCart
//
//  Created by Narendra on 16/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let navigator = UINavigationController()
        appCoordinator = AppCoordinator(navigator: navigator)
        appCoordinator?.start()
        
        window?.rootViewController = navigator
        window?.makeKeyAndVisible()
    }
}

