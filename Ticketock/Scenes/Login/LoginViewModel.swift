//
//  LoginViewModel.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import Foundation


protocol LoginViewModelProtocol {
    var view: LoginViewProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didTapLoginButton(email: String, password: String)
}

final class LoginViewModel {
    weak var view: LoginViewProtocol?
}


// MARK: - LoginViewModelProtocol

extension LoginViewModel: LoginViewModelProtocol {

    func viewDidLoad() {
        view?.configureUI()
        view?.configureToolBar()
    }
    
    func viewWillAppear() {
        view?.configureNavBar()
    }
    
    func didTapLoginButton(email: String, password: String) {
        guard let self = self.view as? LoginViewController else { return }
        
        let loginUserRequest = LoginUserModal(
            email: email ,
            password: password
        )
        
        // Email check
        if !ValidationManager.isValidEmail(for: loginUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
//        if !ValidateManager.isValidPassword(for: registerUserRequest.password) {
//            AlertManager.showInvalidPasswordAlert(on: self)
//            return
//        }
                
        AuthManager.shared.signIn(with: loginUserRequest) { result in
            switch result {
            case .success:
                if let sceneDelegate = self.view?.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                } else {
                    AlertManager.showSignInErrorAlert(on: self)
                }
            case .failure(let error):
                AlertManager.showSignInErrorAlert(on: self, with: error)
            }
        }
    
    }
    
}
