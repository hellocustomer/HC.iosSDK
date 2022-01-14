//
//  HelloCustomerTouchPointConfig.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 18/09/2021.
//

import UIKit

public struct HelloCustomerTouchPointConfig {
    
    let authorization: String
    let companyId: UUID
    let touchpointId: UUID
    let questionFont: UIFont
    let hintFont: UIFont
    let questionaireUrlBuilder: QuestionaireUrlBuilder

    public init(
        authorization: String,
        companyId: UUID,
        touchpointId: UUID,
        questionFont: UIFont = UIFont.boldSystemFont(ofSize: 18),
        hintFont: UIFont = UIFont.systemFont(ofSize: 14),
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
