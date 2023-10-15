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
    
    private let button = CustomButton(title: "TAP", hasBackground: true, fontSize: .big)
    
    
    
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
        addSubview(button)

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            
            button.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            

        ])
    
    }
    
    
    @objc private func didTapButton() {
        print("Tapped")
    }
// MARK: - Helper Functions
    
//    private func fetchUser() {
//        AuthManager.shared.fetchUser { [weak self] result in
//            
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let user):
//                    self.usernameLabel.text = user.username
//                    self.emailLabel.text = user.email
//                case .failure(let error):
//                    print("Profile Error: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
}
