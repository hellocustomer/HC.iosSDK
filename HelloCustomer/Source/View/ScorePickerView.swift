//
//  ScorePickerView.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 25/07/2021.
//

import Foundation
import UIKit

class ScorePickerView: UIView {
    
    fileprivate static let spacing = CGFloat(8)
    fileprivate static let standardButtonSize = CGFloat(44)
    
    private var touchpointConfig: ModalConfig!
    private weak var delegate: ScoreButtonDelegate?
    private let buttonColorResolver = ScoreButtonColorResolver()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: computeValuesForTopStackView())
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = ScorePickerView.spacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView? = {
        guard let viewsToShow = computeValuesForBottomStackView() else {
            return nil
        }
        let stackView = UIStackView(arrangedSubviews: viewsToShow)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = ScorePickerView.spacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView])
        if let bottomStack = bottomStackView {
            stackView.addArrangedSubview(bottomStack)
        }
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = ScorePickerView.spacing
        stackView.alignment = .center
        return stackView
    }()
    
    convenience init(touchpointConfig: ModalConfig, frame: CGRect, delegate: ScoreButtonDelegate) {
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
    
    private func computeValuesForTopStackView() -> [UIView] {
        let questionType = touchpointConfig.questionType
        var views = [UIView]()
        switch questionType {
        case .ces:
            if questionType.shouldShowAllControllsInSingleLine(screenWidth: frame.width) {
                views.append(contentsOf: createButtons(from: 1, to: 7))
            } else {
                views.append(contentsOf: createButtons(from: 1, to: 4))
            }
        case .csat:
            views.append(contentsOf: createButtons(from: 1, to: 5))
        case .nps:
            if questionType.shouldShowAllControllsInSingleLine(screenWidth: frame.width) {
                views.append(contentsOf: createButtons(from: 0, to: 10))
            } else {
                views.append(contentsOf: createButtons(from: 0, to: 5))
            }
        }
        return views
    }
    
    private func computeValuesForBottomStackView() -> [UIView]? {
        let questionType = touchpointConfig.questionType
        var views = [UIView]()
        switch questionType {
        case .ces:
            if questionType.shouldShowAllControllsInSingleLine(screenWidth: frame.width) {
                return nil
            } else {
                views.append(contentsOf: createButtons(from: 5, to: 7))
            }
        case .csat:
            return nil
        case .nps:
            if questionType.shouldShowAllControllsInSingleLine(screenWidth: frame.width) {
                return nil
            } else {
                views.append(contentsOf: createButtons(from: 6, to: 10))
            }
        }
        return views
    }
    
    private func createButtons(from: Int, to: Int) -> [ScoreButton] {
        var buttonsArray = [ScoreButton]()
        let buttonSize = computeButtonSize()
        var fontSize: CGFloat? = nil
        if (touchpointConfig.labeledQuestionView) {
            fontSize = touchpointConfig.buttonLabels.values.map{ String($0).idealFontSize(font: UIFont.systemFont(ofSize: 14), width: buttonSize.width - 12, minSize: 12) }.min()
        }

        for index in from...to {
            var customLabel: String? = nil
            if touchpointConfig.labeledQuestionView {
                customLabel = touchpointConfig.buttonLabels[index]
            }
             
            let button = ScoreButton(
                number: index,
                customLabel: customLabel,
                backgroundColor: buttonColorResolver.resolveBackgroundColorForButton(
                    buttonNumber: index,
                    config: touchpointConfig
                ),
                textColor: buttonColorResolver.resolveTextColorForButton(config: touchpointConfig),
                fontSize: fontSize,
                delegate: delegate
            )
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonSize.width),
                button.heightAnchor.constraint(equalToConstant: buttonSize.height)
            ])
            buttonsArray.append(button)
        }
        return buttonsArray
    }
    
    private func computeButtonSize() -> CGSize {
        let spaceRequiredForOneButton = ScorePickerView.spacing + ScorePickerView.standardButtonSize
        if (touchpointConfig.labeledQuestionView){
            let buttonsInSingleLine: CGFloat
            if (touchpointConfig.questionType.shouldShowAllControllsInSingleLine(screenWidth: frame.width)) {
                buttonsInSingleLine = 7
            } else {
                buttonsInSingleLine = 4
            }
            var spaceRequiredForOneLabeledButton = (frame.width - (buttonsInSingleLine * ScorePickerView.spacing)) / buttonsInSingleLine
            
            if spaceRequiredForOneLabeledButton / 2 > ScorePickerView.standardButtonSize {
                spaceRequiredForOneLabeledButton = ScorePickerView.standardButtonSize * 2
            }
            return CGSize(width: spaceRequiredForOneLabeledButton, height: ScorePickerView.standardButtonSize)
        } else {
            if frame.width / 6 > spaceRequiredForOneButton {
                let size = ScorePickerView.standardButtonSize
                return CGSize(width: size, height: size)
            } else {
                let size = (frame.width - 6 * ScorePickerView.spacing) / 6
                return CGSize(width: size, height: size)
            }
        }
    }
    
    
    
}

fileprivate extension QuestionType {
    
    func numberOfControlls() -> Int {
        switch self {
        case .ces:
            return 8
        case .csat:
            return 6
        case .nps:
            return 11
        }
    }
    
    func shouldShowAllControllsInSingleLine(screenWidth: CGFloat) -> Bool {
        switch self {
        case .nps, .ces:
            return (Int(screenWidth) - numberOfControlls() * Int((ScorePickerView.spacing + ScorePickerView.standardButtonSize))) > 0
        case .csat:
            return true
        }
    }
    
}

extension String {
    func idealFontSize(font: UIFont, width: CGFloat, minSize: CGFloat? = nil) -> CGFloat {
        let baseFontSize = CGFloat(10)
        let textSize = self.size(withAttributes: [NSAttributedString.Key.font: font.withSize(baseFontSize)])
        let ratio = width / textSize.width
        let ballparkSize = baseFontSize * ratio
        let stoppingSize = ballparkSize / CGFloat(2)
        var idealSize = ballparkSize
        while (idealSize > stoppingSize && self.size(withAttributes: [NSAttributedString.Key.font: font.withSize(idealSize)]).width > width) {
            idealSize -= 0.5
        }
        if let minSize = minSize {
            if idealSize > minSize {
                return minSize
            }
        }
        return idealSize
    }
}
