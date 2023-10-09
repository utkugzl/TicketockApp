//
//  ProfileViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 29.09.2023.
//

import UIKit


final class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let profileTableView = UITableView(frame: .zero, style: .grouped)
    
    enum ProfileCellType {
        case headerImage
        case options
    }
    var cellTypes: [ProfileCellType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureUI()
        view.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: "ProfileUserImageTableViewCell", bundle: .main), forCellReuseIdentifier: "ProfileUserImageTableViewCell")
        profileTableView.register(UINib(nibName: "ProfileUserInfoTableViewCell", bundle: .main), forCellReuseIdentifier: "ProfileUserInfoTableViewCell")
        profileTableView.register(UINib(nibName: "ProfileOptionsTableViewCell", bundle: .main), forCellReuseIdentifier: "ProfileOptionsTableViewCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTypes.count // İki bölüm ekliyoruz.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellTypes[section] {
            
        case .headerImage:
            return 2
        case .options:
            return 5
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellTypes[indexPath.section] {
        case .headerImage:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserImageTableViewCell", for: indexPath) as? ProfileUserImageTableViewCell else {
                    return UITableViewCell()
                }
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserInfoTableViewCell", for: indexPath) as? ProfileUserInfoTableViewCell else {
                    return UITableViewCell()
                }
                
                AuthManager.shared.fetchUser { [weak self] result in
                    
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let user):
                            
                            cell.usernameLabel.text = user.username
                            cell.emailLabel.text = user.email
                        case .failure(let error):
                            print("Profile Error: \(error.localizedDescription)")
                        }
                    }
                }
                
                
                return cell
            }
        

        case .options:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTableViewCell", for: indexPath) as? ProfileOptionsTableViewCell else {
                return UITableViewCell()
            }
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypes[indexPath.section] {
        case .headerImage:
            if indexPath.row == 0 {
                return 160
            } else {
                return 80
            }
        case .options:
            return 60
        }
    }
    
    private func configureUI() {
        profileTableView.frame = view.bounds
        cellTypes.append(.headerImage)
        cellTypes.append(.options)
    }

}








