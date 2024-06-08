//
//  SceneDelegate.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        configureFirstScreen()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
//        if let token = UserDefaults.standard.string(forKey: "Token")  {
//            FirebaseManager().userActive(token: token, online: false)
//        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.

    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        if let token = UserDefaults.standard.string(forKey: "Token")  {
            FirebaseManager().userActive(token: token, online: true)
            FirebaseManager().updateMessageStatus(receiver: token, newStatus: "deliver") { success in
                if success {
                    print("Message updated successfully")
                } else {
                    print("Failed to update message")
                }
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        if let token = UserDefaults.standard.string(forKey: "Token")  {
            FirebaseManager().userActive(token: token, online: false)
        }
    }
}
extension SceneDelegate {
    func configureFirstScreen() {
            if let screen = UserDefaults.standard.string(forKey: "Screen"), screen == "Home" {
                let navigationController = UINavigationController()
                navigationController.pushViewController(TabbarBuilder().build(with: navigationController), animated: true)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
            } else {
                let navigationController = UINavigationController()
                navigationController.pushViewController(CreateUserBuilder().build(with: navigationController), animated: true)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
            }
    }
}
