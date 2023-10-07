//
//  RegisterViewModel.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import Foundation


protocol RegisterViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func didTapRegisterButton(username: String, email: String, password: String)

}

final class RegisterViewModel {
    weak var view :RegisterViewProtocol?
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
        guard let self = self.view as? RegisterViewController else { return }
        
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
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            case .failure(let error):
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
            }
        }

    }
 
}

