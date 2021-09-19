//
//  QuestionaireUrlBuilder.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 19/09/2021.
//

import Foundation

private let baseOpinionsUrl = "opinions-development.hellocustomer.com"

class QuestionaireUrlBuilder {
    
    private let userLocaleProvider: UserLocaleProvider
    let metadata: [String:String]
    let respondentFirstName: String?
    let respondentLastName: String?
    let respondentEmailAddress: String?
    let authorization: String
    let companyId: String
    let touchpointId: String
    var userScore: Int?
    
    internal init(
        userLocaleProvider: UserLocaleProvider = UserLocaleProvider(),
        metadata: [String : String],
        respondentFirstName: String?,
        respondentLastName: String?,
        respondentEmailAddress: String?,
        authorization: String,
        companyId: String,
        touchpointId: String
    ) {
        self.userLocaleProvider = userLocaleProvider
        self.metadata = metadata
        self.respondentFirstName = respondentFirstName
        self.respondentLastName = respondentLastName
        self.respondentEmailAddress = respondentEmailAddress
        self.authorization = authorization
        self.companyId = companyId
        self.touchpointId = touchpointId
    }

    func buildQuestionaireUrl() -> URL {
        var queryItems = metadata.map{ URLQueryItem(name: "entry.metadata[\($0.key)]", value: $0.value) }
        if let respondentFirstName = respondentFirstName {
            queryItems.append(URLQueryItem(name: "entry.respondent.firstname", value: respondentFirstName))
        }
        if let respondentLastName = respondentLastName {
            queryItems.append(URLQueryItem(name: "entry.respondent.lastname", value: respondentLastName))
        }
        if let respondentEmailAddress = respondentEmailAddress {
            queryItems.append(URLQueryItem(name: "entry.respondent.email", value: respondentEmailAddress))
        }
        if let userScore = userScore {
            queryItems.append(URLQueryItem(name: "entry.score", value: String(userScore)))
        }
        var urlComponents = URLComponents(string: "https://\(baseOpinionsUrl)/\(userLocaleProvider.getUserLocaleCode())/AskAnywhereCampaign/\(companyId)/\(touchpointId)")!
        urlComponents.queryItems = queryItems

        return urlComponents.url!
    }
    
}
