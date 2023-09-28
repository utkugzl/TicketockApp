//
//  AuthHeaderView.swift
//  Ticketock
//
//  Created by Utku Güzel on 28.09.2023.
//

import UIKit

final class AuthHeaderView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: AppConstants.Images.autheHeaderViewImage))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
        

}

// MARK: - Configurations

extension AuthHeaderView {
    
    private func configureUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = bounds.width
        imageView.frame = CGRect(x: 0,
                                 y: 100,
                                 width: imageSize,
                                 height: 200)
        
        titleLabel.frame = CGRect(x: 10,
                                  y: imageView.bottom,
                                  width: width - 20,
                                  height: 40)
        
        subtitleLabel.frame = CGRect(x: 10,
                                     y: titleLabel.bottom,
                                     width: width - 20,
                                     height: 40)
    }

}
