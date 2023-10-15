//
//  MovieCollectionViewCell.swift
//  Ticketock
//
//  Created by Utku Güzel on 15.10.2023.
//

import UIKit
import Kingfisher

final class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MovieCollectionViewCell.self)
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func setup(with modal: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(modal)") else {
            return
        }
        posterImageView.kf.setImage(with: url)
    }
    
    
    
    
}
