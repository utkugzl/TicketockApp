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
            setupWindow(with: scene)
            checkAuthentication()
        }
    }
    
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            goToController(LoginViewController())
        } else {
            goToController(MainTabBarViewController())
        }
    }
    
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.makeKeyAndVisible()
    }
    
    
    private func goToController(_ viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                var newRootViewController: UIViewController?
                if let tabBarController = viewController as? UITabBarController {
                    newRootViewController = tabBarController
                } else {
                    newRootViewController = UINavigationController(rootViewController: viewController)
                    (newRootViewController as? UINavigationController)?.modalPresentationStyle = .fullScreen
                }
                self?.window?.rootViewController = newRootViewController
                
                UIView.animate(withDuration: 0.25) {
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
    

}

