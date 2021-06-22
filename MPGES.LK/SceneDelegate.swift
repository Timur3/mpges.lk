//
//  SceneDelegate.swift
//  mpges.lk
//
//  Created by Timur on 21.10.2019.
//  Copyright © 2019 ChalimovTimur. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //guard let _ = (scene as? UIWindowScene) else { return }
        
        let rootNavigationController = UINavigationController()
        rootNavigationController.navigationBar.isTranslucent = true
        //rootNavigationController.navigationBar.prefersLargeTitles = true
        // Initialise the first coordinator with the main navigation controller
        
        mainCoordinator = MainCoordinator(navigationController: rootNavigationController)
        
        // The start method will actually display the main view
//        mainCoordinator?.authObserver = UserDefaultsObserver(key: "isAuth")  { old, new in
//            if !(new as? Bool ?? false) {
//                DispatchQueue.main.async {
//                    let firstViewController : FirstTVController = FirstTVController()
//                    firstViewController.delegate = self.mainCoordinator
//                    rootNavigationController.isNavigationBarHidden = false
//                    rootNavigationController.popToRootViewController(animated: true)
//                }
//            }
//        }
        
        mainCoordinator?.start()
        
        if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
            window.rootViewController = rootNavigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Вызывается, когда сцена перешла из неактивного состояния в активное.
        // Используйте этот метод для перезапуска всех задач, которые были приостановлены (или еще не запущены), когда сцена была неактивна.
        print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

