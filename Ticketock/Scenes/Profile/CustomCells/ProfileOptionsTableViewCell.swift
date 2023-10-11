//
//  ProfileOptionsTableViewCell.swift
//  Ticketock
//
//  Created by Utku Güzel on 9.10.2023.
//

import UIKit

final class ProfileOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with modal: ProfileOptionsModal) {
        symbolImageView.image = modal.symbol
        titleLabel.text = modal.title
    }
    
}
