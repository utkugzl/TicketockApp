//
//  Constants.swift
//  Ticketock
//
//  Created by Utku Güzel on 28.09.2023.
//

import Foundation


struct AppConstants {
    static let scheme = "https"
    static let host = "api.themoviedb.org"
    static let baseURL = "https://api.themoviedb.org"
    static let API_KEY = "c06d0d900e9e29187d3512d249f7fa60"
    
    struct UserDefaultsKeys {
        static let notFirstInApp = "notFirstInApp"
    }
    
    struct Symbols {
        static let closeKeyboardSymbol = "keyboard.chevron.compact.down"
        static let profileFavoriteMoviesSymbol = "heart.fill"
        static let profilePaymnetMethodsSymbol = "creditcard.fill"
        static let profileAccountSettingsSymbol = "lock.fill"
        static let profileHelpSymbol = "questionmark.circle"
        static let profileLogOutSymbol = "rectangle.portrait.and.arrow.forward"
    }
    
    struct Images {
        static let onboarding1 = "onboarding1"
        static let onboarding2 = "onboarding2"
        static let onboarding3 = "onboarding3"
        static let autheHeaderViewImage = "authHeader"
        static let user = "user"
    }
    
    struct Regex {
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        static let usernameRegex = "\\w{4,24}"
        static let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$#!%*?&])[A-Za-z\\d@$#!%*?&]{6,32}$"
    }
    
}
