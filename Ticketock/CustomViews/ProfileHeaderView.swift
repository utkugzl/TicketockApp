//
//  ProfileHeaderView.swift
//  Ticketock
//
//  Created by Utku Güzel on 5.10.2023.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: AppConstants.Images.user))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.label.cgColor
        imageView.layer.cornerRadius = 75
        return imageView
    }()
    
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Configure UI

extension ProfileHeaderView {
    
    private func configureUI() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(emailLabel)
        
        fetchUser()
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    
    }
    

// MARK: - Helper Functions
    
    private func fetchUser() {
        AuthManager.shared.fetchUser { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.usernameLabel.text = user.username
                    self.emailLabel.text = user.email
                case .failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
