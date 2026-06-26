//
//  SceneDelegate.swift
//  Example
//
//  Created by Daniel Hernandez on 26/06/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        
        // modo claro
        window.overrideUserInterfaceStyle = .light
        
        let navigationController = UINavigationController(
            rootViewController: MainRouter().viewController
        )
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

