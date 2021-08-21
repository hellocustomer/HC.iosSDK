//
//  TouchpointConfig.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 28/07/2021.
//

import UIKit


struct TouchpointConfig: Decodable {
    
    let question: String
    let questionTextSize: Int
    let leftHint: String
    let rightHint: String
    let questionType: QuestionType
    let buttonColor: String
    let questionaireUrl: String
    
}
