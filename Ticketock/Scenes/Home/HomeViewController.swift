//
//  HomeViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 2.10.2023.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}



// MARK: - Configure UI

extension HomeViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
}

