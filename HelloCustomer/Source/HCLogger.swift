//
//  HCLogger.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 31/07/2021.
//

import Foundation

class HCLogger {
    
    static var loggingEnabled = false
    static func logD(_ message: String) {
        if loggingEnabled{
            NSLog(message)
        }
    }
    
    static func logE(_ error: Error,_ message: String = ""){
        if loggingEnabled {
            NSLog(message)
            print(error)
        }
    }
        
}
