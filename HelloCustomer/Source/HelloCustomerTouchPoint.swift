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
        config: HelloCustomerTouchPointConfig,
        viewController: UIViewController,
        resultDelegate: @escaping (Result<QuestionModal, Error>) -> Void
    ) {
        loadInternal(
            config: config,
            viewController: viewController,
            resultDelegate: resultDelegate
        )
    }
    
    static func loadInternal(
        config: HelloCustomerTouchPointConfig,
        viewController: UIViewController,
        resultDelegate: @escaping (Result<QuestionModal, Error>) -> Void,
        service: TouchPointService = TouchPointService()
    ) {
        HCLogger.logD("Downloading touchpoint config")
        service.downloadTouchPointConfig(config: config) { result in
            switch result {
            case .success(let config):
                DispatchQueue.main.async {
                    let modal: QuestionModal
                    switch config.modalType {
                    case .bottomSheet:
                        modal = BottomSheetModalViewController.create(parent: viewController, touchpointConfig: config)
                    case .dialog:
                        modal = DialogModalViewController.create(parent: viewController, touchpointConfig: config)
                    }
                    resultDelegate(.success(modal))
                    HCLogger.logD("Downloaded touchpoint config successfully")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    resultDelegate(.failure(error))
                }
            }
        }
    }
    
}
