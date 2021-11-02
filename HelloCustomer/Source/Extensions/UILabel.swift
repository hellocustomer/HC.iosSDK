//
//  UILabel.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 29/10/2021.
//

import Foundation

extension UILabel {
    
    func approximateAdjustedFontSizeWithLabel() -> CGFloat {
        var currentFont: UIFont = self.font
        let originalFontSize = currentFont.pointSize
        var currentSize: CGSize = (self.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])

        while currentSize.width > self.frame.size.width && currentFont.pointSize > (originalFontSize * self.minimumScaleFactor) {
            currentFont = currentFont.withSize(currentFont.pointSize - 1.0)
            currentSize = (self.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])
        }

        return currentFont.pointSize
    }
    
}
