//
//  HCLogger.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 31/07/2021.
//

import Foundation

class HCLogger {
    
    static func logD(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        print(items, separator: separator, terminator: terminator)
    }
        
}
