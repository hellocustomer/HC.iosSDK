//
//  TouchpointConfig.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 28/07/2021.
//

import UIKit

struct ModalConfig {
    
    let question: String
    let questionFont: UIFont
    let leftHint: String?
    let rightHint: String?
    let hintFont: UIFont
    let questionType: QuestionType
    let buttonBackgroundColor: String
    let showColorScaleOnButtons: Bool
    let buttonTextColor: String
    let questionTextColor: String
    let hintTextColor: String
    let modalType: QuestionModalType
    let questionaireUrlBuilder: QuestionaireUrlBuilder
    
    var userScore: Int? = nil
}
