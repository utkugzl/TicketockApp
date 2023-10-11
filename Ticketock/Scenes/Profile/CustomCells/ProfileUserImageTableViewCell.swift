//
//  ProfileUserImageTableViewCell.swift
//  Ticketock
//
//  Created by Utku Güzel on 9.10.2023.
//

import UIKit

final class ProfileUserImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        profileImageView.layer.borderWidth = 3
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.red.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        profileImageView.clipsToBounds = true
    }

    
}

