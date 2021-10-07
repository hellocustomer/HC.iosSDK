//
//  QuestionModal.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import Foundation

public protocol QuestionModal: AnyObject {
    
    func display()
    
}

public enum QuestionModalType {
    case bottomSheet
    case dialog
}
