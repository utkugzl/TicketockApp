//
//  OnboardingCollectionViewCell.swift
//  Ticketock
//
//  Created by Utku Güzel on 26.09.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    

    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    func setup(_ model: OnboardingModel) {
        onboardingImageView.image = model.image
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    


}
