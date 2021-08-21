//
//  TouchPointLoadResult.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import Foundation

public enum TouchPointLoadResult {
    case success(QuestionModal)
    case error(Error)
}
