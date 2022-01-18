//
//  ViewController.swift
//  Example
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import UIKit
import HelloCustomer

class ViewController: UIViewController {
    
    private lazy var touchpointDict = {
        NSDictionary(contentsOfFile: Bundle.main.path(forResource: "touchpoint", ofType: "plist")!) as! Dictionary<String, AnyObject>
    }()
    
    private lazy var hcAuthToken = {
        touchpointDict["HcAuthToken"] as! String
    }()
    
    private lazy var companyId: UUID = {
        UUID.init(uuidString: touchpointDict["HcCompanyId"] as! String)
    }()!
    
    private lazy var touchpoint1Id: UUID = {
        UUID.init(uuidString: touchpointDict["HcTouchpoint1Id"] as! String)
    }()!
    
    private lazy var touchpoint2Id: UUID = {
        UUID.init(uuidString: touchpointDict["HcTouchpoint2Id"] as! String)
    }()!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    @IBAction func didTouchPoint1Clicked(_ sender: Any) {
        HelloCustomerTouchPoint.load(
            config: HelloCustomerTouchPointConfig(
                authorization: hcAuthToken,
                companyId: companyId,
                touchpointId: touchpoint1Id
            ),
            viewController: self,
            resultDelegate: onTouchPointResult
        )
    }
    
    @IBAction func didTouchPoint2Clicked(_ sender: Any) {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "YY/MM/dd hh:mm"
        let customMetadata = [
            "testDate": dateFormmater.string(from: Date()),
            "userBattery": String(UIDevice.current.batteryLevel)
        ]
        
        HelloCustomerTouchPoint.load(
            config: HelloCustomerTouchPointConfig(
                authorization: hcAuthToken,
                companyId: companyId,
                touchpointId: touchpoint2Id,
                questionFont: UIFont(name: "Earwig Factory", size: UIFont.labelFontSize)!,
                hintFont: UIFont(name: "Comic Sans MS", size: 12)!,
                metadata: customMetadata,
                respondentFirstName: "User first name",
                respondentLastName: "Last name",
                respondentEmailAddress: "email"
            ),
            viewController: self,
            resultDelegate: onTouchPointResult
        )
    }
    
    @IBAction func didTouchPoint3Clicked(_ sender: Any) {
        HelloCustomerTouchPoint.checkIfTouchpointIsActive(
            config: HelloCustomerTouchPointConfig(
                authorization: hcAuthToken,
                companyId: companyId,
                touchpointId: touchpoint1Id
            ),
            viewController: self,
            resultDelegate: { result in
                switch result {
                case .success(let result):
                    let alertController = UIAlertController(
                        title: "Result",
                        message: "Is touchpoint active: " + String(result),
                        preferredStyle: .alert
                    )
                    let defaultAction = UIAlertAction(
                        title: NSLocalizedString("Ok", comment: ""),
                        style: .default,
                        handler: { (pAlert) in
                            alertController.dismiss(animated: true, completion: nil)
                        })
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    break
                case .failure(let error):
                    self.showErrorDialog(error: error)
                }
            }
        )
    }
    
    private func onTouchPointResult(result: Result<QuestionModal, Error>) {
        switch result {
        case .success(let modal):
            modal.display()
        case .failure(let error):
            showErrorDialog(error: error)
        }
    }
    
    private func showErrorDialog(error: Error){
        let alertController = UIAlertController(
            title: "An error occurred",
            message: String(describing: error.self),
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(
            title: NSLocalizedString("Ok", comment: ""),
            style: .default,
            handler: { (pAlert) in
                alertController.dismiss(animated: true, completion: nil)
            })
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

