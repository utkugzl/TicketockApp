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
            goToController(with: LoginViewController())
        } else {
            goToController(with: ProfileViewController())
        }
    }
    
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.makeKeyAndVisible()
    }
    
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) {
                    self?.window?.layer.opacity = 1
                }
            }

        }
    }

}

