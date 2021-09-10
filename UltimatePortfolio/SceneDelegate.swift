//
//  SceneDelegate.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 09.09.2021.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void) {
        guard let url = URL(string: shortcutItem.type) else {
            completionHandler(false)
            return
        }
        
        UIApplication.shared.open(url, completionHandler: completionHandler)
    }
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            guard let url = URL(string: shortcutItem.type) else {
                return
            }
            
            UIApplication.shared.open(url)
        }
    }
}
