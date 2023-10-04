//
//  ProfileTableViewCell.swift
//  Ticketock
//
//  Created by Utku Güzel on 4.10.2023.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ProfileTableViewCell.self)
    
    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    
    func setup(with model: ProfileTableViewCellModel) {
        symbolImageView.image = model.symbolImage
        titleLabel.text = model.title
    }
  
}
