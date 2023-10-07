//
//  ProfileViewModal.swift
//  Ticketock
//
//  Created by Utku Güzel on 7.10.2023.
//

import UIKit

protocol ProfileViewModalProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func didTapLogoutButton()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(_ tableView: UITableView, indexPath: IndexPath)
}


final class ProfileViewModal {
    weak var view: ProfileViewProtocol?
    private var sections = [ProfileTableViewCellModel]()
    
    private func configureSections() {
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: AppConstants.Symbols.profileFavoriteMoviesSymbol)!, title: "Favorite Movies", handler: {
            DispatchQueue.main.async {
                print("Favorite Movies Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: AppConstants.Symbols.profilePaymnetMethodsSymbol)!, title: "Paymnet Methods", handler: {
            DispatchQueue.main.async {
                print("Paymnet Methods Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: AppConstants.Symbols.profileAccountSettingsSymbol)!, title: "Account Settings", handler: {
            DispatchQueue.main.async {
                print("Account Settings Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: AppConstants.Symbols.profileHelpSymbol)!, title: "Help", handler: {
            DispatchQueue.main.async {
                print("Help Tapped")
            }
        }))
        sections.append(ProfileTableViewCellModel(symbolImage: UIImage(systemName: AppConstants.Symbols.profileLogOutSymbol)!, title: "Log Out", handler: {
            DispatchQueue.main.async { [self] in
                didTapLogoutButton()
            }
        }))
    }

}

extension ProfileViewModal: ProfileViewModalProtocol {
    
    func viewDidLoad() {
        view?.configureUI()
        view?.configureHeaderView()
    }
    
    func viewWillAppear() {
        configureSections()
    }
    
    func numberOfRowsInSection() -> Int {
        return sections.count
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: sections[indexPath.row])
        return cell
    }
    
    func didSelectRowAt(_ tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.row]
        model.handler()

    }
    
    func didTapLogoutButton() {
        guard let self = self.view as? ProfileViewController else { return }
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



