//
//  BottomSheetModalViewController.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import Foundation
import UIKit

class BottomSheetModalViewController: AbstractBottomSheetViewController, QuestionModal, ModalQuestionViewDelegate {
    
    
    static func create(
        parent: UIViewController,
        touchpointConfig: TouchpointConfig
    ) -> BottomSheetModalViewController {
        let bottomSheetModalViewController = BottomSheetModalViewController()
        bottomSheetModalViewController.parentVC = parent
        bottomSheetModalViewController.touchpointConfig = touchpointConfig
        bottomSheetModalViewController.modalPresentationStyle = .overCurrentContext
        return bottomSheetModalViewController
    }
    
    private lazy var modalQuestionView: ModalQuestionView = {
        return createModalQuestionView(frame: self.view.frame)
    }()
    
    private lazy var surveyView: SurveyView = {
        let view = SurveyView()
        view.delegate = self
        return view
    }()
        
    private var isShowingSurvey = false
    private weak var parentVC: UIViewController?
    private var touchpointConfig: TouchpointConfig!
    private var surveyViewConstraint: NSLayoutConstraint!
    
    func display() {
        guard let parentVC = parentVC else {
            HCLogger.logD("parrentVC is nil")
            return
        }
        parentVC.present(self, animated: false, completion: {})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if isShowingSurvey {
            self.surveyViewConstraint!.constant = size.height
            self.view.layoutIfNeeded()
            return
        }
        modalQuestionView.removeFromSuperview()
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        modalQuestionView = createModalQuestionView(frame: frame)
        constraintModalQuestionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        defaultHeight = modalQuestionView.computeRequiredHeight(parentWidth: view.frame.width)
        super.viewDidAppear(animated)
    }
    
    
    @objc func onCloseClick() {
        animateDismissView()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        constraintModalQuestionView()
    }
    
    private func createModalQuestionView(frame: CGRect) -> ModalQuestionView {
        return ModalQuestionView(touchpointConfig: touchpointConfig, frame: frame, delegate: self)
    }
    
    func didValueChoosen(value: Int) {
        isShowingSurvey = true
        showSurveyPage(size: self.view.frame.size)
    }
    
    private func showSurveyPage(size: CGSize) {
        containerView.addSubview(surveyView)
        surveyViewConstraint = surveyView.heightAnchor.constraint(equalToConstant: size.height)
        modalQuestionView.removeFromSuperview()
        surveyView.translatesAutoresizingMaskIntoConstraints = false

        UIView.animate(withDuration: 0.4) {
            NSLayoutConstraint.activate([
                self.surveyViewConstraint!,
                self.surveyView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                self.surveyView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
                self.surveyView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                self.surveyView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
            ])
            self.view.layoutIfNeeded()
        }
    }
    
    private func constraintModalQuestionView() {
        containerView.addSubview(modalQuestionView)
        modalQuestionView.closeButton.addTarget(self,
                                                action: #selector(onCloseClick),
                                                for: .touchUpInside)
        
        modalQuestionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modalQuestionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            modalQuestionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            modalQuestionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            modalQuestionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
}

extension BottomSheetModalViewController: SurveyViewDelegate {
    
    func closeClicked() {
        dismiss(animated: true, completion: nil)
    }
    
}
