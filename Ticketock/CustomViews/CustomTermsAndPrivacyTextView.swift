//
//  CustomTermsAndPrivacyTextView.swift
//  Ticketock
//
//  Created by Utku Güzel on 28.09.2023.
//

import UIKit

enum LinkType {
    case termsAndConditions
    case privacyPolicy

    var stringValue: String {
        switch self {
        case .termsAndConditions:
            return "Terms & Conditions"
        case .privacyPolicy:
            return "Privacy Policy"
        }
    }

    var linkValue: String {
        switch self {
        case .termsAndConditions:
            return "terms://termsAndConditions"
        case .privacyPolicy:
            return "privacy://privacyPolicy"
        }
    }
}


final class CustomTermsAndPrivacyTextView: UITextView {
    
    init(){
        super.init(frame: .zero, textContainer: nil)
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy")
        attributedString.addAttribute(.link, value: LinkType.termsAndConditions.linkValue, range: (attributedString.string as NSString).range(of: LinkType.termsAndConditions.stringValue))
        attributedString.addAttribute(.link, value: LinkType.privacyPolicy.linkValue, range: (attributedString.string as NSString).range(of: LinkType.privacyPolicy.stringValue))
        
        self.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        self.attributedText = attributedString
        self.isEditable = false
        self.isSelectable = true
        self.delaysContentTouches = false
        self.textAlignment = .center
        self.textColor = .secondaryLabel
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
