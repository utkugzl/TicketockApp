//
//  ProfileViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 29.09.2023.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func configureUI()
    func prepareProfileTableView()
    func showLogOutAlert()
}

final class ProfileViewController: UIViewController {
    
    private let profileTableView = UITableView(frame: .zero, style: .grouped)
    
    private lazy var viewModal =  ProfileViewModal()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModal.view = self
        viewModal.viewDidLoad()
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileViewController :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModal.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModal.cellForRowAt(tableView: tableView, indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModal.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModal.didSelectRowAt(tableView: tableView, indexPath: indexPath)
    }
}


// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func showLogOutAlert() {
        AlertManager.showLogOutAlert(on: self) { _ in
            self.viewModal.signOut()
        }
    }
    
    func prepareProfileTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: "ProfileUserImageTableViewCell", bundle: .main), forCellReuseIdentifier: "ProfileUserImageTableViewCell")
        profileTableView.register(UINib(nibName: "ProfileUserInfoTableViewCell", bundle: .main), forCellReuseIdentifier: "ProfileUserInfoTableViewCell")
        profileTableView.register(UINib(nibName: "ProfileOptionsTableViewCell", bundle: .main), forCellReuseIdentifier: "ProfileOptionsTableViewCell")
    }
    
    func configureUI() {
        profileTableView.frame = view.bounds
        view.addSubview(profileTableView)
    }
    
}








