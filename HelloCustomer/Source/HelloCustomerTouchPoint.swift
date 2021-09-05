//
//  HelloCustomer.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import Foundation
import UIKit

public final class HelloCustomerTouchPoint {
    
    public static func load(
        touchPointId: String,
        viewController: UIViewController,
        modalType: QuestionModalType? = nil,
        resultDelegate: @escaping (TouchPointLoadResult) -> Void
    ) {
        //let modalType = modalType ?? computeProperModalType()
        resultDelegate(.success(BottomSheetModalViewController.create(parent: viewController, touchpointConfig: mockConfig())))
        return
//        loadInternal(
//            touchPointId: touchPointId,
//            viewController: viewController,
//            modalType: modalType,
//            resultDelegate: resultDelegate
//        )
    }
    
    static func loadInternal(
        touchPointId: String,
        viewController: UIViewController,
        modalType: QuestionModalType,
        resultDelegate: @escaping (TouchPointLoadResult) -> Void,
        service: TouchPointService = TouchPointService()
    ) {
        service.downloadTouchPointConfig(touchPointId: touchPointId) { result in
            switch result {
            case .success(let config):
                let modal: QuestionModal
                switch modalType {
                case .bottomSheet:
                    modal = BottomSheetModalViewController.create(parent: viewController, touchpointConfig: config)
                case .dialog:
                    modal = DialogModalViewController.create(parent: viewController, touchpointConfig: config)
                }
            
                resultDelegate(.success(modal))
            case .error(let error):
                resultDelegate(.error(error))
        }
        
        
    }
    }
    
    static func computeProperModalType() -> QuestionModalType {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .bottomSheet
        } else {
            return .dialog
        }
    }
    
    private static func mockConfig() -> TouchpointConfig {
        return TouchpointConfig(
            question: "How satisfied were you with your recent experience with Hello Customer app?How satisfied were you with your recent experience with Hello Customer app?How satisfied were you with your recent experience with Hello Customer app?How satisfied were you with your recent experience with Hello Customer app?How satisfied were you with your recent experience with Hello Customer app?",
            questionTextSize: 18,
            leftHint: "0 - Not likely",
            rightHint: "10 - Very much",
            questionType: .nps,
            buttonColor: "#CCFFFF",
            questionaireUrl: "https://www.youtube.com/watch?v=EnE1hPlrRgc"
        )
    }
    
}
