//
//  ForgotPasswordViewModalProtocol.swift
//  Ticketock
//
//  Created by Utku Güzel on 11.10.2023.
//

import Foundation

protocol ForgotPasswordViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func didTapResetPasswordButton(email: String)
}
