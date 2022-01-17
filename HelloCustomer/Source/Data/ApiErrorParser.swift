//
//  ApiErrorParser.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 17/01/2022.
//

import Foundation

class ApiErrorParser {
    
    static let CampaignIsOutOfProductionApiError = "The campaign is not set to production."

    
    func parse(data: Data?, response: URLResponse?) -> HelloCustomerSdkError? {
        do {
            if let code = (response as? HTTPURLResponse)?.statusCode, code == 401 {
                return HelloCustomerSdkError.unauthorizedException
            }
            let message = try JSONDecoder().decode([String].self, from: data!).first!
            switch message {
            case ApiErrorParser.CampaignIsOutOfProductionApiError:
                return HelloCustomerSdkError.campaignIsOutOfProduction
            case nil:
                return nil
            default:
                return HelloCustomerSdkError.apiErrorMessageException(apiMessage: message)
            }
        } catch {
            return nil
        }
    }
    
}
