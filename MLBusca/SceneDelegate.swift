//
//  SceneDelegate.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let rootViewController = ViewController()
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
