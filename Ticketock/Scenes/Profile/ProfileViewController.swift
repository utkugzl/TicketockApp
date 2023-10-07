//
//  ProfileViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 29.09.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let ProfileTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()

    private var sections = [ProfileTableViewCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: sections[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.row]
        model.handler()
    }

}


// MARK: - Configure UI

extension ProfileViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(ProfileTableView)
        ProfileTableView.register(UINib(nibName: ProfileTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
        configureHeaderView()
        configureModels()
        makeProfileTableView()
        
        ProfileTableView.delegate = self
        ProfileTableView.dataSource = self

    }
    
    private func makeProfileTableView() {
        ProfileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ProfileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProfileTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ProfileTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ProfileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureHeaderView() {
        ProfileTableView.tableHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: ProfileTableView.width, height: 240))
    }

    private func configureModels() {
        
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: "heart.fill")!, title: "Favorite Movies", handler: {
            DispatchQueue.main.async {
                print("Favorite Movies Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: "creditcard.fill")!, title: "Paymnet Methods", handler: {
            DispatchQueue.main.async {
                print("Paymnet Methods Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: "lock.fill")!, title: "Account Settings", handler: {
            DispatchQueue.main.async {
                print("Account Settings Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: "questionmark.circle")!, title: "Help", handler: {
            DispatchQueue.main.async {
                print("Help Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: "rectangle.portrait.and.arrow.forward")!, title: "Log Out", handler: {
            DispatchQueue.main.async {
                self.didTapLogOutButton()
            }
        }))
    }

}


// MARK: - Helper Functions

extension ProfileViewController {
    
    private func didTapLogOutButton() {
        AuthManager.shared.signOut { result in
            switch result {
            case .success():
                if let scnDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    scnDelegate.checkAuthentication()
                }
            case.failure(let error):
                AlertManager.showLogoutErrorAlert(on: self, with: error)
            }
        }
    }
}


