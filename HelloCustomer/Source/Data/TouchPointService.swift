//
//  TouchPointService.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 01/08/2021.
//

import Foundation

private let baseUrlPath = "api.hellocustomer.com"
private let apiVersion = "V2.0"
private let campaignTypeMobile = 4

class TouchPointService {
    
    private let userLocaleProvider: UserLocaleProvider
    private let touchpointConfigResolver: TouchpointConfigResolver
    private let apiErrorParser = ApiErrorParser()
    
    internal init(
        userLocaleProvider: UserLocaleProvider = UserLocaleProvider(),
        touchpointConfigResolver: TouchpointConfigResolver = TouchpointConfigResolver()
    ) {
        self.userLocaleProvider = userLocaleProvider
        self.touchpointConfigResolver = touchpointConfigResolver
    }
    
    func downloadTouchPointConfig(
        config: HelloCustomerTouchPointConfig,
        resultDelegate: @escaping (Result<ModalConfig, Error>) -> Void
    ) {
        downloadTouchPointQuestions(
            config: config,
            resultDelegate: { result in
                switch result {
                case .success(let question):
                    if(question.campaignType != nil && question.campaignType != campaignTypeMobile){
                        resultDelegate(.failure(HelloCustomerSdkError.touchpointCampaignIsNotMobileTypeException))
                        return
                    }
                    self.downloadTouchPointDesigns(config: config, resultDelegate: { designsResult in
                        switch designsResult {
                        case .success(let designs):
                            let config = self.touchpointConfigResolver.mapToTouchpointConfig(
                                config: config,
                                survey: question,
                                designs: designs
                            )
                            resultDelegate(.success(config))
                        case .failure(let error):
                            resultDelegate(.failure(error))
                        }
                    })
                case .failure(let error):
                    resultDelegate(.failure(error))
                }
            }
        )
    }
    
    private func downloadTouchPointQuestions(
        config: HelloCustomerTouchPointConfig,
        resultDelegate: @escaping (Result<SurveyDto, Error>) -> Void
    ) {
        HCLogger.logD("Downloading touchpoint questions")
        URLSession.shared.dataTask(with: buildQuestionsRequest(config)) { (data, response, sessionError) -> Void in
            if sessionError == nil && data != nil {
                do {
                    HCLogger.logD("Downloaded touchpoint questions successfully")
                    let decoder = JSONDecoder()
                    let survey = try decoder.decode([SurveyDto].self, from: data!)
                    resultDelegate(.success(survey.first!))
                } catch {
                    if let apiError = self.apiErrorParser.parse(data: data, response: response) {
                        HCLogger.logE(apiError, "Downloaded touchpoint questions failrue")
                        resultDelegate(.failure(apiError))
                        return
                    }
                    HCLogger.logE(error, "Downloaded touchpoint questions failrue")
                    resultDelegate(.failure(error))
                }
            } else if let sessionError = sessionError {
                resultDelegate(.failure(sessionError))
            } else {
                resultDelegate(.failure(NSError(domain: "Unknows error", code: 1, userInfo: nil)))
            }
        }.resume()
    }
    
    private func downloadTouchPointDesigns(
        config: HelloCustomerTouchPointConfig,
        resultDelegate: @escaping (Result<[SurveyLanguageDesignDto], Error>) -> Void
    ) {
        HCLogger.logD("Downloading touchpoint designs")
        URLSession.shared.dataTask(with: buildLanguageDesignRequest(config)) { (data, response, sessionError) -> Void in
            if sessionError == nil && data != nil {
                do {
                    HCLogger.logD("Downloaded touchpoint designs")
                    let decoder = JSONDecoder()
                    let designs = try decoder.decode([SurveyLanguageDesignDto].self, from: data!)
                    resultDelegate(.success(designs))
                } catch {
                    if let apiError = self.apiErrorParser.parse(data: data, response: response) {
                        HCLogger.logE(apiError, "Downloaded touchpoint designs failrue")
                        resultDelegate(.failure(apiError))
                        return
                    }
                    HCLogger.logE(error, "Downloaded touchpoint designs failrue")
                    resultDelegate(.failure(error))
                }
            } else if let sessionError = sessionError {
                resultDelegate(.failure(sessionError))
            } else {
                resultDelegate(.failure(NSError(domain: "Unknows error", code: 1, userInfo: nil)))
            }
        }.resume()
    }
    
    private func buildQuestionsRequest(_ config: HelloCustomerTouchPointConfig) -> URLRequest {
        let userLanguageCode = userLocaleProvider.getUserLocaleCode()
        let url = URL(string: "https://\(baseUrlPath)/\(apiVersion)/\(userLanguageCode)/company/\(config.companyId)/touchpoint/\(config.touchpointId)/question/GetTouchpointSurveyQuestions")!
        var request = URLRequest(url: url)
        request.setValue("basic \(config.authorization)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func buildLanguageDesignRequest(_ config: HelloCustomerTouchPointConfig) -> URLRequest {
        let userLanguageCode = userLocaleProvider.getUserLocaleCode()
        let url = URL(string: "https://\(baseUrlPath)/\(apiVersion)/\(userLanguageCode)/company/\(config.companyId)/touchpoint/\(config.touchpointId)/askanywheretemplate/GetTouchpointSurveyDesign")!
        var request = URLRequest(url: url)
        request.setValue("basic \(config.authorization)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}
