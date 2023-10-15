//
//  ProfileViewModal.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import UIKit

enum ProfileSections {
    case headerImage
    case options
}

final class ProfileViewModal {
    weak var view: ProfileViewProtocol?
    
    var profileSections: [ProfileSections] = []
    var profileOptions: [ProfileOptionsModal] = []
    
    private func prepareArrays() {
        profileSections.append(.headerImage)
        profileSections.append(.options)
        
        profileOptions.append(ProfileOptionsModal(symbol: UIImage(systemName: AppConstants.Symbols.profileFavoriteMoviesSymbol)!, title: "Favorite Movies") {
            print("Favorite Movies")
        })
        profileOptions.append(ProfileOptionsModal(symbol: UIImage(systemName: AppConstants.Symbols.profilePaymnetMethodsSymbol)!, title: "Paymnent Methods") {
            print("Paymnent Methods")
        })

        profileOptions.append(ProfileOptionsModal(symbol: UIImage(systemName: AppConstants.Symbols.profileAccountSettingsSymbol)!, title: "Account Settings") {
            print("Account Settings")
        })

        profileOptions.append(ProfileOptionsModal(symbol: UIImage(systemName: AppConstants.Symbols.profileHelpSymbol)!, title: "Help") {
            print("Help")
        })

        profileOptions.append(ProfileOptionsModal(symbol: UIImage(systemName: AppConstants.Symbols.profileLogOutSymbol)!, title: "Log Out") {
            self.view?.showLogOutAlert()
        })
    }
    
    
}

extension ProfileViewModal: ProfileViewModalProtocol{

    func viewDidLoad() {
        view?.prepareProfileTableView()
        view?.configureUI()
        prepareArrays()
    }
    
    func signOut() {
        AuthManager.shared.signOut { result in
            switch result {
            case .success():
                AuthManager.shared.checkAuthentication()
            case .failure(_):
                print("Failed to log out")
            }
        }
    }
    
    func numberOfSections() -> Int {
        profileSections.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch profileSections[section] {
            
        case .headerImage:
            return profileSections.count
        case .options:
            return profileOptions.count
        }
    }
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch profileSections[indexPath.section] {
        case .headerImage:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserImageTableViewCell", for: indexPath) as? ProfileUserImageTableViewCell else {
                    return UITableViewCell()
                }
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserInfoTableViewCell", for: indexPath) as? ProfileUserInfoTableViewCell else {
                    return UITableViewCell()
                }
                
                let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(activityIndicator)
                NSLayoutConstraint.activate([
                    activityIndicator.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
                ])
                activityIndicator.startAnimating()
                
                AuthManager.shared.fetchUser { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let user):
                            cell.usernameLabel.text = user.username
                            cell.emailLabel.text = user.email
                            activityIndicator.stopAnimating()
                            activityIndicator.isHidden = true
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
            cell.setup(with: profileOptions[indexPath.row])
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return cell
        }
    }
    
    func didSelectRowAt(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profileOption = profileOptions[indexPath.row]
        profileOption.handler()
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch profileSections[indexPath.section] {
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
    
    
}




