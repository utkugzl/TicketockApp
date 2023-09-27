//
//  CustomButton.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case med
        case small
    }

    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.layer.masksToBounds = true
        
        
        self.layer.cornerRadius = 10.0
        self.backgroundColor = hasBackground ? .red : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .red
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize {

        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
