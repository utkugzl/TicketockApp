//
//  LoginViewModelProtocol.swift
//  Ticketock
//
//  Created by Utku Güzel on 8.10.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    var view: LoginViewProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didTapLoginButton(email: String, password: String)
    func didTabCreateAccountButton()
    func didTabForgotPasswordButton()
}



