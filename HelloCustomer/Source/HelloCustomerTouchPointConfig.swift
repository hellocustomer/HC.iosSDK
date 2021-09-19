//
//  HelloCustomerTouchPointConfig.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 18/09/2021.
//

import UIKit

public struct HelloCustomerTouchPointConfig {
    
    let authorization: String
    let companyId: String
    let touchpointId: String
    let questionFont: UIFont
    let hintFont: UIFont
    let questionaireUrlBuilder: QuestionaireUrlBuilder

    public init(
        authorization: String,
        companyId: String,
        touchpointId: String,
        questionFont: UIFont = UIFont.systemFont(ofSize: 14),
        hintFont: UIFont = UIFont.systemFont(ofSize: 10),
        metadata: [String:String] = [:],
        respondentFirstName: String? = nil,
        respondentLastName: String? = nil,
        respondentEmailAddress: String? = nil
    ) {
        self.authorization = authorization
        self.companyId = companyId
        self.touchpointId = touchpointId
        self.questionFont = questionFont
        self.hintFont = hintFont
        self.questionaireUrlBuilder = QuestionaireUrlBuilder(
            metadata: metadata,
            respondentFirstName: respondentFirstName,
            respondentLastName: respondentLastName,
            respondentEmailAddress: respondentEmailAddress,
            authorization: authorization,
            companyId: companyId,
            touchpointId: touchpointId
        )
    }
}
