//
//  HelloCustomerSdkError.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 17/01/2022.
//

import Foundation

public enum HelloCustomerSdkError: Error {
        
    case touchpointCampaignIsNotMobileTypeException
    
    case apiErrorMessageException(apiMessage: String)
    
    case campaignIsOutOfProduction
    
    case unauthorizedException
}
