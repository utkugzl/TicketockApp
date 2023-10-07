//
//  ProfileViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 29.09.2023.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func configureUI()
    func configureHeaderView()
}


final class ProfileViewController: UIViewController {
    
    private let ProfileTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()
  
    private lazy var viewModal = ProfileViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModal.view = self
        viewModal.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModal.viewWillAppear()
    }

}

extension ProfileViewController: ProfileViewProtocol {
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(ProfileTableView)
        ProfileTableView.register(UINib(nibName: ProfileTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.identifier)

        makeProfileTableView()
        
        ProfileTableView.delegate = self
        ProfileTableView.dataSource = self

    }
    
    func configureHeaderView() {
        ProfileTableView.tableHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: ProfileTableView.width, height: 240))
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModal.cellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModal.didSelectRowAt(tableView, indexPath: indexPath)
    }

}


// MARK: - Configure UI

extension ProfileViewController {
    
    private func makeProfileTableView() {
        ProfileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ProfileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProfileTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ProfileTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ProfileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


// MARK: - Helper Functions

extension ProfileViewController {
    
    private func didTapLogOutButton() {
        viewModal.didTapLogoutButton()
    }
}


