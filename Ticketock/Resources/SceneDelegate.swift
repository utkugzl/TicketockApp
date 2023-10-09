//
//  SceneDelegate.swift
//  Ticketock
//
//  Created by Utku Güzel on 26.09.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if(UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.notFirstInApp) == false){
            UserDefaults.standard.set(true, forKey: AppConstants.UserDefaultsKeys.notFirstInApp)
            setupWindow(with: scene)
            window?.rootViewController = OnboardingViewController()
        }else{
            AuthManager.shared.checkAuthentication()
            setupWindow(with: scene)
        }
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.makeKeyAndVisible()
    }
}

