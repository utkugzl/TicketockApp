//
//  ProfileViewModelProtocol.swift
//  Ticketock
//
//  Created by Utku Güzel on 8.10.2023.
//

import UIKit

protocol ProfileViewModalProtocol {
    var view: ProfileViewProtocol? { get set }
    
    func viewDidLoad()
    func signOut()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func didSelectRowAt(tableView: UITableView, indexPath: IndexPath)
}
