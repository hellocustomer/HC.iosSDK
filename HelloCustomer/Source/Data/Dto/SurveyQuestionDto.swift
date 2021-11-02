
import Foundation

struct SurveyQuestionDto: Codable {
    
    let languageUniqueID: String
    let languageCulture: String
    let text: String
    let siblingUniqueID: String
    let hasbeenArchived: Bool
    let label1: String?
    let label2: String?
    let label3: String?
    let label4: String?
    let label5: String?
    let label6: String?
    let label7: String?
    let rateType: Int?
    let sortOrder: Int
    let type: SurveyQuestionTypeDto
    let hasAnswers: Bool
    let isMandatory: Bool
    let campaignUniqueID: String
    let uniqueID: String

    enum CodingKeys: String, CodingKey {
        case languageUniqueID = "language_UniqueID"
        case languageCulture = "language_Culture"
        case text = "text"
        case siblingUniqueID = "siblingUniqueID"
        case hasbeenArchived = "hasbeenArchived"
        case label1 = "label1"
        case label2 = "label2"
        case label3 = "label3"
        case label4 = "label4"
        case label5 = "label5"
        case label6 = "label6"
        case label7 = "label7"
        case rateType = "rateType"
        case sortOrder = "sortOrder"
        case type = "type"
        case hasAnswers = "hasAnswers"
        case isMandatory = "isMandatory"
        case campaignUniqueID = "campaign_UniqueID"
        case uniqueID = "uniqueID"
    }
}

// MARK: - TypeClass
struct SurveyQuestionTypeDto: Codable {
    let name: String
    let hasScore: Bool
    let hasText: Bool
    let hasBoolean: Bool
    let siblingUniqueID: String
    let defaultRateType: Int?
    let hasDefaultText: Bool
    let hasMetadata: Bool
    let isLabel1Required: Bool
    let isLabel2Required: Bool
    let isLabel3Required: Bool
    let isLabel4Required: Bool
    let isLabel5Required: Bool
    let isLabel6Required: Bool
    let isLabel7Required: Bool
    let uniqueID: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case hasScore = "hasScore"
        case hasText = "hasText"
        case hasBoolean = "hasBoolean"
        case siblingUniqueID = "siblingUniqueID"
        case defaultRateType = "defaultRateType"
        case hasDefaultText = "hasDefaultText"
        case hasMetadata = "hasMetadata"
        case isLabel1Required = "isLabel1Required"
        case isLabel2Required = "isLabel2Required"
        case isLabel3Required = "isLabel3Required"
        case isLabel4Required = "isLabel4Required"
        case isLabel5Required = "isLabel5Required"
        case isLabel6Required = "isLabel6Required"
        case isLabel7Required = "isLabel7Required"
        case uniqueID = "uniqueID"
    }
}
