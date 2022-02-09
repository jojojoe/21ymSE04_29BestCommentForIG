//
//  SceneDelegate.swift
//  BCIymBestComment
//
//  Created by mac on 2021/12/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainVC: BCIymMainVC = BCIymMainVC()

    func initMainVC() {
        let nav = UINavigationController.init(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        #if DEBUG
        for fy in UIFont.familyNames {
            let fts = UIFont.fontNames(forFamilyName: fy)
            for ft in fts {
                debugPrint("***fontName = \(ft)")
            }
        }
        #endif
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         
        guard let _ = (scene as? UIWindowScene) else { return }
        initMainVC()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
         
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
         
    }

    func sceneWillResignActive(_ scene: UIScene) {
         
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
         
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
         
    }


}


