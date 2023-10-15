//
//  String+Extension.swift
//  Ticketock
//
//  Created by Utku Güzel on 15.10.2023.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
