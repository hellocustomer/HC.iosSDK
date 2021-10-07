//
//  ModalQuestionView.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import Foundation
import UIKit

class ModalQuestionView: UIView, ScoreButtonDelegate {

    static let horizontalPadding = CGFloat(16)
    
    private var touchpointConfig: ModalConfig!
    
    private weak var delegate: ModalQuestionViewDelegate?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "close", in: bundle, compatibleWith: nil)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = UIColor(red: 0.678, green: 0.71, blue: 0.741, alpha: 1)
        
        return button
    }()
    
    lazy var closeButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(), closeButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = touchpointConfig.question
        label.font = touchpointConfig.questionFont
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var numberPicker: ScorePickerView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width - 2 * ModalQuestionView.horizontalPadding, height: 0)
        let picker = ScorePickerView(touchpointConfig: touchpointConfig, frame: frame, delegate: self)
        picker.frame = CGRect(x: 0, y: 0, width: picker.frame.width, height: 200)
        
        return picker
    }()
    
    lazy var bottomHintsView: UIView = {
        let labelsView = BottomHintLabelsView(touchpointConfig: touchpointConfig)
        return labelsView
    }()
    
    lazy var contentStackView: UIStackView = {
        let spacer0 = UIView()
        let spacer1 = UIView()
        let spacer2 = UIView()
        NSLayoutConstraint.activate([
            spacer0.heightAnchor.constraint(equalToConstant: 8),
            spacer1.heightAnchor.constraint(equalToConstant: 16),
            spacer2.heightAnchor.constraint(equalToConstant: 8)
        ])
        let stackView = UIStackView(arrangedSubviews: [
                                        closeButtonStackView,
                                        spacer0,
                                        questionLabel,
                                        spacer1,
                                        numberPicker,
                                        spacer2,
                                        bottomHintsView
        ]
        )
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    convenience init(touchpointConfig: ModalConfig, frame: CGRect, delegate: ModalQuestionViewDelegate) {
        self.init(frame: frame)
        self.touchpointConfig = touchpointConfig
        self.delegate = delegate
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func didClick(value: Int) {
        delegate?.didValueChoosen(value: value)
    }
    
    func computeRequiredHeight(parentWidth: CGFloat) -> CGFloat {
        let questionLabelHeight = questionLabel.heightForView(width: parentWidth)
        contentStackView.layoutIfNeeded()
        bottomHintsView.layoutIfNeeded()
        return closeButton.frame.height + questionLabelHeight + numberPicker.frame.height + bottomHintsView.frame.height
    }
    
    private func setupView() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ModalQuestionView.horizontalPadding),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ModalQuestionView.horizontalPadding)
        ])
    }
    
    
}

protocol ModalQuestionViewDelegate: AnyObject {
    func didValueChoosen(value: Int)
}

extension UILabel {
    func heightForView(width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        label.layoutIfNeeded()
        return label.frame.height
    }
}
