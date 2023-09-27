//
//  CustomKeyboardToolbar.swift
//  Ticketock
//
//  Created by Utku Güzel on 27.09.2023.
//

import UIKit

final class CustomKeyboardToolbar: UIToolbar {

    var textFields: [UITextField] = []

    init(textFields: [UITextField]) {
        super.init(frame: CGRect.zero)
        self.textFields = textFields
        configureToolbar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureToolbar()
    }



    @objc private func didTapcloseKeyboard() {
        for textField in textFields {
            textField.resignFirstResponder()
        }
    }
}

// MARK: - Configurations

extension CustomKeyboardToolbar {
    
    private func configureToolbar() {
        sizeToFit()
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        setShadowImage(UIImage(), forToolbarPosition: .any)
        tintColor = .secondaryLabel
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(didTapcloseKeyboard))
        items = [flexibleSpace, closeButton]
    }
}



