//
//  ProfileViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 29.09.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        AuthManager.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            if let user = user {
                label.text = "\(user.username)\n\(user.email)"
            }
        }
    }

}


// MARK: - Configure UI

extension ProfileViewController {
        
        private func configureUI() {
            view.backgroundColor = .systemBackground
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(didTapLogOutButton))

            view.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        }
  
}


// MARK: - Selectors

extension ProfileViewController {
    
    @objc func didTapLogOutButton() {
        AuthManager.shared.signOut { [weak self ]error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutErrorAlert(on: self, with: error)
                return
            }
            
            if let scnDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                scnDelegate.checkAuthentication()
            }
            
        }
    }
}


