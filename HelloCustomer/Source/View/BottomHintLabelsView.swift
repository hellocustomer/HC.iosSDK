//
//  BottomHintLabelsView.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 25/07/2021.
//

import Foundation
import UIKit

class BottomHintLabelsView: UIView {
    
    private var touchpointConfig: ModalConfig!
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = touchpointConfig.hintTextColor
        label.font = touchpointConfig.hintFont
        label.text = touchpointConfig.leftHint
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = touchpointConfig.hintTextColor
        label.font = touchpointConfig.hintFont
        label.text = touchpointConfig.rightHint
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [leftLabel, spacer, rightLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    convenience init(touchpointConfig: ModalConfig) {
        self.init(frame: CGRect())
        self.touchpointConfig = touchpointConfig
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
}
