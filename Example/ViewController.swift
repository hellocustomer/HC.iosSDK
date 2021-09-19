//
//  ViewController.swift
//  Example
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import UIKit
import HelloCustomer

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    @IBAction func didTouchPoint1Clicked(_ sender: Any) {
        HelloCustomerTouchPoint.load(
            config: HelloCustomerTouchPointConfig(
                authorization: "eyJhbGciOiAiSFM1MTIiLCAidHlwIjogIkpXVCJ9.eyJhdWQiOiJhNDk2NTY1MC03MGVhLTRhZmMtOTBlOS01YTJmZjRmNzFjMjkiLCJzdWIiOiJlNGE2ZmNkZi0yYmE3LTQ3ZDQtYTA0NS0wNTAyZmI2ZTNmMGYiLCJpc3MiOiJodHRwczovL2hlbGxvY3VzdG9tZXIuY29tIiwiaWF0IjoxNjMxNzkyMjAzLCJleHAiOjE2NjMzMjgxNDUsIm1kIjp7InByIjp7ImExciI6ZmFsc2UsImFtciI6ZmFsc2UsInJiZSI6ZmFsc2UsInJ1ZSI6ZmFsc2UsInJyIjpmYWxzZSwiZ25wcyI6dHJ1ZSwiZ2NlcyI6dHJ1ZSwiZ2NzYXQiOnRydWUsImFhbnN3Ijp0cnVlfSwiaXAiOm51bGwsInRwaWRzIjpbIjIxY2VjYWI0LTljNjEtNDk0OC05MjNkLWQ2YjM4MjFiMzQzOSIsIjg1ZDNhYWQ3LWYxNTUtNDBhZS1iODM1LWU1MTM3ZDdiY2VjYiIsImQ1ZjA3NWI3LTg1NWUtNDQ1My04NmJiLWU4MTYxNDhmNzM2ZSJdfX0=.92NqRJ9qWh2WA8S/XbASdh+2lOPcrCMgoQKoy3+iCFR56ApiyQjW8hJ9b0URbkwKEvZKBv6pL4heNB9jc1NWyA==",
                companyId: "a4965650-70ea-4afc-90e9-5a2ff4f71c29",
                touchpointId: "85d3aad7-f155-40ae-b835-e5137d7bcecb"
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
                authorization: "eyJhbGciOiAiSFM1MTIiLCAidHlwIjogIkpXVCJ9.eyJhdWQiOiJhNDk2NTY1MC03MGVhLTRhZmMtOTBlOS01YTJmZjRmNzFjMjkiLCJzdWIiOiJlNGE2ZmNkZi0yYmE3LTQ3ZDQtYTA0NS0wNTAyZmI2ZTNmMGYiLCJpc3MiOiJodHRwczovL2hlbGxvY3VzdG9tZXIuY29tIiwiaWF0IjoxNjMxNzkyMjAzLCJleHAiOjE2NjMzMjgxNDUsIm1kIjp7InByIjp7ImExciI6ZmFsc2UsImFtciI6ZmFsc2UsInJiZSI6ZmFsc2UsInJ1ZSI6ZmFsc2UsInJyIjpmYWxzZSwiZ25wcyI6dHJ1ZSwiZ2NlcyI6dHJ1ZSwiZ2NzYXQiOnRydWUsImFhbnN3Ijp0cnVlfSwiaXAiOm51bGwsInRwaWRzIjpbIjIxY2VjYWI0LTljNjEtNDk0OC05MjNkLWQ2YjM4MjFiMzQzOSIsIjg1ZDNhYWQ3LWYxNTUtNDBhZS1iODM1LWU1MTM3ZDdiY2VjYiIsImQ1ZjA3NWI3LTg1NWUtNDQ1My04NmJiLWU4MTYxNDhmNzM2ZSJdfX0=.92NqRJ9qWh2WA8S/XbASdh+2lOPcrCMgoQKoy3+iCFR56ApiyQjW8hJ9b0URbkwKEvZKBv6pL4heNB9jc1NWyA==",
                companyId: "a4965650-70ea-4afc-90e9-5a2ff4f71c29",
                touchpointId: "d5f075b7-855e-4453-86bb-e816148f736e",
                questionFont: UIFont(name: "Earwig Factory", size: UIFont.labelFontSize)!,
                hintFont: UIFont(name: "Comic Sans MS", size: UIFont.labelFontSize)!,
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
        HelloCustomerTouchPoint.load(
            config: HelloCustomerTouchPointConfig(
                authorization: "eyJhbGciOiAiSFM1MTIiLCAidHlwIjogIkpXVCJ9.eyJhdWQiOiJhNDk2NTY1MC03MGVhLTRhZmMtOTBlOS01YTJmZjRmNzFjMjkiLCJzdWIiOiJlNGE2ZmNkZi0yYmE3LTQ3ZDQtYTA0NS0wNTAyZmI2ZTNmMGYiLCJpc3MiOiJodHRwczovL2hlbGxvY3VzdG9tZXIuY29tIiwiaWF0IjoxNjMxNzkyMjAzLCJleHAiOjE2NjMzMjgxNDUsIm1kIjp7InByIjp7ImExciI6ZmFsc2UsImFtciI6ZmFsc2UsInJiZSI6ZmFsc2UsInJ1ZSI6ZmFsc2UsInJyIjpmYWxzZSwiZ25wcyI6dHJ1ZSwiZ2NlcyI6dHJ1ZSwiZ2NzYXQiOnRydWUsImFhbnN3Ijp0cnVlfSwiaXAiOm51bGwsInRwaWRzIjpbIjIxY2VjYWI0LTljNjEtNDk0OC05MjNkLWQ2YjM4MjFiMzQzOSIsIjg1ZDNhYWQ3LWYxNTUtNDBhZS1iODM1LWU1MTM3ZDdiY2VjYiIsImQ1ZjA3NWI3LTg1NWUtNDQ1My04NmJiLWU4MTYxNDhmNzM2ZSJdfX0=.92NqRJ9qWh2WA8S/XbASdh+2lOPcrCMgoQKoy3+iCFR56ApiyQjW8hJ9b0URbkwKEvZKBv6pL4heNB9jc1NWyA==",
                companyId: "a4965650-70ea-4afc-90e9-5a2ff4f71c29",
                touchpointId: "21cecab4-9c61-4948-923d-d6b3821b3439"
            ),
            viewController: self,
            resultDelegate: onTouchPointResult
        )
    }
    
    private func onTouchPointResult(result: Result<QuestionModal, Error>) {
        switch result {
        case .success(let modal):
            modal.display()
        case .failure(let error):
            let alertController = UIAlertController(
                title: "An error occurred",
                message: error.localizedDescription,
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
            print(error)
        }
    }
    
}
