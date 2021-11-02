//
//  ScoreButtonColorResolver.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 07/10/2021.
//

import Foundation
import UIKit

class ScoreButtonColorResolver {
    
    private let guardsmanRed = UIColor("#d80b00")
    private let trinidad = UIColor("#f25705")
    private let california = UIColor("#f2a005")
    private let keyLimePie = UIColor("#c0de1d")
    private let chartreuse = UIColor("#7BD500")
    
    
    func resolveTextColorForButton(
        config: ModalConfig
    ) -> UIColor {
        if !config.showColorScaleOnButtons {
            return config.buttonTextColor
        } else {
            return UIColor.white
        }
    }
    
    func resolveBackgroundColorForButton(
        buttonNumber: Int,
        config: ModalConfig
    ) -> UIColor {
        if !config.showColorScaleOnButtons {
            return config.buttonBackgroundColor
        }
        switch config.questionType {
        case .ces:
            return resolveColorScaleBackgroundColorForCes(buttonNumber: buttonNumber)
        case .csat:
            return resolveColorScaleBackgroundColorForCsat(buttonNumber: buttonNumber)
        case .nps:
            return resolveColorScaleBackgroundColorForNps(buttonNumber: buttonNumber)
        }
    }
    
    private func resolveColorScaleBackgroundColorForCes(
        buttonNumber: Int
    ) -> UIColor {
        switch buttonNumber {
        case 1...2:
            return guardsmanRed
        case 3:
            return trinidad
        case 4...5:
            return california
        case 6...7:
            return chartreuse
        default:
            fatalError()
        }
    }
    
    private func resolveColorScaleBackgroundColorForCsat(
        buttonNumber: Int
    ) -> UIColor {
        switch buttonNumber {
        case 1:
            return guardsmanRed
        case 2:
            return trinidad
        case 3:
            return california
        case 4:
            return keyLimePie
        case 5:
            return chartreuse
        default:
            fatalError()
        }
    }
    
    private func resolveColorScaleBackgroundColorForNps(
        buttonNumber: Int
    ) -> UIColor {
        switch buttonNumber {
        case 0...1:
            return guardsmanRed
        case 2...3:
            return trinidad
        case 4...6:
            return california
        case 7...8:
            return keyLimePie
        case 9...10:
            return chartreuse
        default:
            fatalError()
        }
    }
}


