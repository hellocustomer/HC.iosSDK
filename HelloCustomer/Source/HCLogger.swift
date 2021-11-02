//
//  HCLogger.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 31/07/2021.
//

import Foundation

class HCLogger {
    
    static func logD(_ message: String) {
        NSLog(message)
    }
    
    static func logE(_ error: Error,_ message: String = ""){
        NSLog(message)
        print(error)
    }
        
}
