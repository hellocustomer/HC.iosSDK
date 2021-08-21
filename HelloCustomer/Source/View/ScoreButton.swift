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
        color: UIColor = UIColor(red: 0.914, green: 0.925, blue: 0.937, alpha: 1),
        delegate: ScoreButtonDelegate?
    ) {
        self.init(frame: CGRect())
        self.clickDelegate = delegate
        self.number = number
        setTitle(String(number), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        setBackgroundColor(color, forState: .normal)
        setBackgroundColor(color.darker(), forState: .highlighted)
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

protocol ScoreButtonDelegate: class {
    func didClick(value: Int)
}
