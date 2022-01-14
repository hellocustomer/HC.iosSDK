//
//  TouchpointConfigResolver.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 18/09/2021.
//

import UIKit

class TouchpointConfigResolver {
    
    private let userLocaleProvider: UserLocaleProvider
    
    internal init(
        userLocaleProvider: UserLocaleProvider = UserLocaleProvider()
    ) {
        self.userLocaleProvider = userLocaleProvider
    }
    
    func mapToTouchpointConfig(
        config: HelloCustomerTouchPointConfig,
        survey: SurveyDto,
        designs: [SurveyLanguageDesignDto]
    ) -> ModalConfig {
        let firstQuestion = resolveFirstQuestion(survey: survey)
        let targetDesign = resolveTargetDesign(question: firstQuestion, designs: designs)
        config.questionaireUrlBuilder.questionaireLanguage = firstQuestion.languageCulture
        
        return ModalConfig(
            question: firstQuestion.text,
            questionFont: config.questionFont,
            leftHint: firstQuestion.label1,
            rightHint: firstQuestion.label2,
            hintFont: config.hintFont,
            questionType: mapQuestionType(type: firstQuestion.type.name),
            buttonBackgroundColor: UIColor(targetDesign.opinionsButtonBgColor),
            showColorScaleOnButtons: targetDesign.opinionsUseColorScale,
            buttonTextColor: UIColor(targetDesign.opinionsButtonTextColor),
            questionTextColor: UIColor(targetDesign.opinionsQuestionsColor),
            hintTextColor: UIColor(targetDesign.opinionsParagraphColor),
            rateType: firstQuestion.rateType,
            buttonLabels: resolveButtonLabels(firstQuestion),
            modalType: resolveModalType(surveyType: targetDesign.surveyType),
            questionaireUrlBuilder: config.questionaireUrlBuilder
        )
    }
    
    private func resolveButtonLabels(_ question: SurveyQuestionDto) -> [Int: String] {
        var result = [Int: String]()
        if let question1 = question.label1{
            result[1] = question1
        }
        if let question2 = question.label2{
            result[2] = question2
        }
        if let question3 = question.label3{
            result[3] = question3
        }
        if let question4 = question.label4{
            result[4] = question4
        }
        if let question5 = question.label5{
            result[5] = question5
        }
        if let question6 = question.label6{
            result[6] = question6
        }
        if let question7 = question.label7{
            result[7] = question7
        }
        
        return result
    }
    
    private func resolveModalType(surveyType: Int?) -> QuestionModalType {
        switch surveyType {
        case 0:
            return .bottomSheet
        case 1:
            return .dialog
        default:
            return computeProperModalType()
        }
    }
    
    private func resolveFirstQuestion(survey: SurveyDto) -> SurveyQuestionDto {
        let userLanguageCode = userLocaleProvider.getUserLocaleCode()
        let bestMatch = survey.items.first(where: { $0.sortOrder == 1 && $0.languageCulture == userLanguageCode } )
        if let bestMatch = bestMatch {
            return bestMatch
        }
        let englishQuestion = survey.items.first(where: { $0.sortOrder == 1 && $0.languageCulture == "EN" } )
        if let englishQuestion = englishQuestion {
            return englishQuestion
        }
        return survey.items.first(where: { $0.sortOrder == 1} )!
    }
    
    private func resolveTargetDesign(question: SurveyQuestionDto, designs: [SurveyLanguageDesignDto]) -> SurveyLanguageDesignDto {
        return designs.first(where: { $0.languageUniqueID == question.languageUniqueID })!
    }
    
    private func mapQuestionType(type: String) -> QuestionType {
        switch type {
        case "CES Score - 1-7 Question":
            return .ces
        case "CSAT Score - 1-5 Question":
            return .csat
        case "NPS Score - 0-10 Question":
            return .nps
        default:
            preconditionFailure("Not valid type")
        }
    }
    
    private func computeProperModalType() -> QuestionModalType {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .bottomSheet
        } else {
            return .dialog
        }
    }
    
}
