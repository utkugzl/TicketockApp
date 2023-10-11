//
//  RegisterViewModalProtocol.swift
//  Ticketock
//
//  Created by Utku Güzel on 11.10.2023.
//

import Foundation

protocol RegisterViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func didTapRegisterButton(username: String, email: String, password: String)
    func shouldInteractWith(url: URL) -> Bool
}
