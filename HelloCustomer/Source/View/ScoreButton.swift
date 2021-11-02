//
//  ScoreButton.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 26/07/2021.
//

import Foundation
import UIKit

class ScoreButton: UIButton {
    
    private weak var clickDelegate: ScoreButtonDelegate?
    private var number: Int!
    
    convenience init(
        number: Int,
        customLabel: String? = nil,
        backgroundColor: UIColor,
        textColor: UIColor,
        fontSize: CGFloat? = nil,
        delegate: ScoreButtonDelegate?
    ) {
        self.init(frame: CGRect())
        self.clickDelegate = delegate
        self.number = number
        let label = customLabel ?? String(number)
        if let fontSize = fontSize {
            titleLabel?.font = titleLabel?.font.withSize(fontSize)
            titleLabel?.numberOfLines = 2
        }
        titleLabel?.textAlignment = .center
        setTitle(label, for: .normal)
        setTitleColor(textColor, for: .normal)
        setBackgroundColor(backgroundColor, forState: .normal)
        setBackgroundColor(backgroundColor.darker(), forState: .highlighted)
        layer.cornerRadius = 6
        clipsToBounds = true
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        self.clickDelegate?.didClick(value: number)
    }
    
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
          color.setFill()
          UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        }
        setBackgroundImage(colorImage, for: controlState)
      }
    
}

protocol ScoreButtonDelegate: AnyObject {
    func didClick(value: Int)
}


