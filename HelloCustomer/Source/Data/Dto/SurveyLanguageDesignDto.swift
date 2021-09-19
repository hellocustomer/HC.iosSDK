//
//  SurveyLanguageDesignDto.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 18/09/2021.
//

import Foundation

struct SurveyLanguageDesignDto: Codable {
    let languageUniqueID: String
    let contentLabelCopyright: String
    let responseSubmitted: String
    let responseQuarantine: String
    let languageName: String
    let opinionsButtonTextColor: String
    let opinionsButtonBgColor: String
    let opinionsButtonText: String
    let campaignUniqueID: String
    let opinionsUseColorScale: Bool
    let opinionsUseVerticalScaleForMobile: Bool
    let surveyType: Int?
    let opinionsQuestionsFont: String
    let opinionsQuestionsColor: String
    let opinionsParagraphFont: String
    let opinionsParagraphColor: String
    let opinionsShowLogo: Bool
    let uniqueID: String

    enum CodingKeys: String, CodingKey {
        case languageUniqueID = "language_UniqueID"
        case contentLabelCopyright = "content_LabelCopyright"
        case responseSubmitted = "response_Submitted"
        case responseQuarantine = "response_Quarantine"
        case languageName = "language_Name"
        case opinionsButtonTextColor = "opinions_Button_TextColor"
        case opinionsButtonBgColor = "opinions_Button_BgColor"
        case opinionsButtonText = "opinions_Button_Text"
        case campaignUniqueID = "campaign_UniqueID"
        case opinionsUseColorScale = "opinions_UseColorScale"
        case opinionsUseVerticalScaleForMobile = "opinions_UseVerticalScaleForMobile"
        case surveyType = "surveyType"
        case opinionsQuestionsFont = "opinions_Questions_Font"
        case opinionsQuestionsColor = "opinions_Questions_Color"
        case opinionsParagraphFont = "opinions_Paragraph_Font"
        case opinionsParagraphColor = "opinions_Paragraph_Color"
        case opinionsShowLogo = "opinions_ShowLogo"
        case uniqueID = "uniqueID"
    }
}
