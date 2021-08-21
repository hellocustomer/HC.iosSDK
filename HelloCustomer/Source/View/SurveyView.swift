//
//  SurveyView.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 31/07/2021.
//

import UIKit
import WebKit

class SurveyView: UIView, WKNavigationDelegate {
    
    weak var delegate: SurveyViewDelegate?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "close", in: bundle, compatibleWith: nil)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = UIColor(red: 0.678, green: 0.71, blue: 0.741, alpha: 1)
        
        return button
    }()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        let webView = WKWebView()
        webView.navigationDelegate = self
        
        webView.load(URLRequest(url: URL(string: "https://www.hellocustomer.com/en/")!))
        webView.allowsBackForwardNavigationGestures = true
        addSubview(webView)
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false

        closeButton.addTarget(
            self,
            action: #selector(onCloseClick),
            for: .touchUpInside
        )
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 0),
            closeButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            webView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc func onCloseClick() {
        delegate?.closeClicked()
    }
    
}

protocol SurveyViewDelegate: class {
    func closeClicked()
}
