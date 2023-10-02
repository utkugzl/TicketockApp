//
//  MainTabBarViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 2.10.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: BookedTicketsViewController())
        let vc3 = UINavigationController(rootViewController: ProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "ticket")
        vc3.tabBarItem.image = UIImage(systemName: "person")
        
        tabBarItem.badgeColor = .systemBackground
        
        setViewControllers([vc1,vc2,vc3], animated: true)
    }
    

}
