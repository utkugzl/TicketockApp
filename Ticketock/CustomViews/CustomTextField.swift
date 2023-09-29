//
//  CustomTextField.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit


final class CustomTextField: UITextField {

    enum CustomTextFieldType {
        case username
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(authFieldType: CustomTextFieldType) {
        self.authFieldType = authFieldType
        super.init(frame: .zero)
        
        self.leftViewMode = .always
        self.returnKeyType = .done
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        self.backgroundColor = .secondarySystemBackground
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        switch authFieldType {
        case .email:
            self.placeholder = "Email..."
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Password..."
            self.isSecureTextEntry = true
            self.textContentType = .oneTimeCode
        case .username:
            self.placeholder = "Username..."
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
