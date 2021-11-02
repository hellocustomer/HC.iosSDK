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
    let buttonBackgroundColor: UIColor
    let showColorScaleOnButtons: Bool
    let buttonTextColor: UIColor
    let questionTextColor: UIColor
    let hintTextColor: UIColor
    let rateType: Int?
    let buttonLabels: [Int : String]
    let modalType: QuestionModalType
    let questionaireUrlBuilder: QuestionaireUrlBuilder
    
    var userScore: Int? = nil
    
    var labeledQuestionView: Bool {
        get {
            self.rateType == 4 && self.questionType == .ces
        }
    }
}
