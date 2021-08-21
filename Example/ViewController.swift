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
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didButtonClicked(_ sender: Any) {
        HelloCustomerTouchPoint.load(
            touchPointId: "TEST",
            viewController: self,
            resultDelegate: onTouchPointResult
        )
    }
    
    private func onTouchPointResult(result: TouchPointLoadResult) {
        switch result {
        case .success(let modal):
            modal.display()
        case .error(let error):
            print(error)
        }
    }

}
