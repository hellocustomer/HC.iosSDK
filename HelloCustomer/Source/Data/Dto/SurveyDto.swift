//
//  SurveyDto.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 18/09/2021.
//

import Foundation

struct SurveyDto: Codable {
    let campaignUniqueID: String
    let hasbeenArchived: Bool
    let sortOrder: Int
    let items: [SurveyQuestionDto]

    enum CodingKeys: String, CodingKey {
        case campaignUniqueID = "campaign_UniqueID"
        case hasbeenArchived = "hasbeenArchived"
        case sortOrder = "sortOrder"
        case items = "items"
    }
}
