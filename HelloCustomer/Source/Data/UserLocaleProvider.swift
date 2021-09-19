//
//  UserLocaleProvider.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 18/09/2021.
//

import Foundation

class UserLocaleProvider {
    
    func getUserLocaleCode() -> String {
        if let pref = Locale.preferredLanguages.first {
            
            let locale = Locale(identifier: pref)
            let code = [locale.languageCode, locale.scriptCode].compactMap{$0}.joined(separator: "-").uppercased()
            return code
        }
        return "EN"
    }
    
}
