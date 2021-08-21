//
//  BottomHintLabelsView.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 25/07/2021.
//

import Foundation
import UIKit


class BottomHintLabelsView: UIView {
    
    private var touchpointConfig: TouchpointConfig!
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.424, green: 0.459, blue: 0.49, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        label.text = touchpointConfig.leftHint
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.424, green: 0.459, blue: 0.49, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        label.text = touchpointConfig.rightHint
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [leftLabel, spacer, rightLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    convenience init(touchpointConfig: TouchpointConfig) {
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
