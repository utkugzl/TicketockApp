//
//  MainTabBarViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 3.10.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}


// MARK: - Configure UI

extension MainTabBarViewController {
    
    private func configureUI() {
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = BookedTicketsViewController()
        let vc4 = ProfileViewController()

        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Tickets"
        vc4.title = "Profile"

        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        vc4.navigationItem.largeTitleDisplayMode = .always

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)

        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        nav4.navigationBar.tintColor = .label

        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Tickets", image: UIImage(systemName: "ticket"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true

        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
        
    }
}

