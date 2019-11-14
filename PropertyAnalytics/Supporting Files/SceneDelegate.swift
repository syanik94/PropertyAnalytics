//
//  SceneDelegate.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/11/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            let loginVC = LoginViewController()
            window.rootViewController = loginVC
            self.window = window
            window.overrideUserInterfaceStyle = .light
            window.makeKeyAndVisible()
        }
    }
}

