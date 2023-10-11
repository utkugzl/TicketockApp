//
//  RegisterViewModel.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import UIKit


final class RegisterViewModel {
    weak var view :RegisterViewProtocol?
    
    private func showWebViewerController(with urlString: String) {
        guard let presentingViewController = view as? UIViewController else {
            return
        }
        
        let vc = WebViewerController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        presentingViewController.present(nav, animated: true)
    }
}

extension RegisterViewModel: RegisterViewModelProtocol {
 
    func viewDidLoad() {
        view?.configureUI()
        view?.configureToolBar()
    }
    
    func viewWillAppear() {
        view?.configureNavBar()
    }
    
    func didTapRegisterButton(username: String, email: String, password: String) {
        
        let registerUserRequest = RegisterUserModal(
            username: username,
            email: email,
            password: password
        )
        
        // Username check
//        if !ValidationManager.isValidUsername(for: registerUserRequest.username) {
//            AlertManager.showInvalidUsernameAlert(on: view)
//            return
//        }
        // Email check
//        if !ValidationManager.isValidEmail(for: registerUserRequest.email) {
//            AlertManager.showInvalidEmailAlert(on: self)
//            return
//        }
        
        // Password check
//        if !ValidateManager.isValidPassword(for: registerUserRequest.password) {
//            AlertManager.showInvalidPasswordAlert(on: self)
//            return
//        }
        
        AuthManager.shared.registerUser(with: registerUserRequest) { result in
            
            switch result {
            case .success:
                AuthManager.shared.checkAuthentication()
            case .failure(let error):
                self.view?.showRegistrationErrorAlert(error: error)
            }
        }

    }
    
    func shouldInteractWith(url: URL) -> Bool {
        guard let identifier = url.scheme else { return false }
        
        switch identifier {
        case "terms":
            showWebViewerController(with: "https://policies.google.com/terms?hl=en")
            return false
        case "privacy":
            showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
            return false
        default:
            return false
        }
    }
 
}

