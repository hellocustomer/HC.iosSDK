//
//  DialogModalViewController.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 31/07/2021.
//

import UIKit

class DialogModalViewController: UIViewController, QuestionModal, ModalQuestionViewDelegate {
    
    static func create(
        parent: UIViewController,
        touchpointConfig: ModalConfig
    ) -> DialogModalViewController {
        let vc = DialogModalViewController()
        vc.parentVC = parent
        vc.touchpointConfig = touchpointConfig
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }
    
    private let maxWidth = CGFloat(400)
    private var isShowingSurvey = false
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
    
    private lazy var surveyView: SurveyView = {
        let view = SurveyView()
        view.touchpointConfig = touchpointConfig
        view.delegate = self
        return view
    }()
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    private var touchpointConfig: ModalConfig!
    private weak var parentVC: UIViewController?
    private lazy var modalQuestionView: ModalQuestionView = {
        return createModalQuestionView(view.frame.size)
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
           return .darkContent
        } else {
            return .default
        }
    }
    
    func display() {
        guard let parentVC = parentVC else {
            HCLogger.logD("parrentVC is nil")
            return
        }
        parentVC.definesPresentationContext = true
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        parentVC.present(self, animated: true, completion: {})
    }
    
    func didValueChoosen(value: Int) {
        isShowingSurvey = true
        touchpointConfig.questionaireUrlBuilder.userScore = value
        showSurveyPage()
    }
    
    private func showSurveyPage() {
        containerView.addSubview(surveyView)
        modalQuestionView.removeFromSuperview()
        surveyView.translatesAutoresizingMaskIntoConstraints = false
        
        UIView.animate(withDuration: 0.4) {
            NSLayoutConstraint.activate([
                self.surveyView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                self.surveyView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
                self.surveyView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                self.surveyView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                
                self.containerView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        constraintView()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if isShowingSurvey {
            return
        }
        coordinator.animate(alongsideTransition: { [self] (UIViewControllerTransitionCoordinatorContext) -> Void in
            UIView.performWithoutAnimation {
                modalQuestionView.removeFromSuperview()
                containerView.removeFromSuperview()
                scrollView.addSubview(containerView)
                modalQuestionView = createModalQuestionView(size)
                constraintModalQuestionView(size)
            }
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
        })
        
    }
    
    @objc private func onCloseClick() {
        dismiss(animated: true, completion: nil)
    }
    
    private func createModalQuestionView(_ size: CGSize) -> ModalQuestionView {
        let modal =  ModalQuestionView(
            touchpointConfig: self.touchpointConfig,
            frame: computeFrameForDialog(size),
            delegate: self
        )
        modal.closeButton.addTarget(
            self,
            action: #selector(onCloseClick),
            for: .touchUpInside
        )
        return modal
    }
    
    private func constraintView() {
        view.addSubview(dimmedView)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        constraintModalQuestionView(view.frame.size)
    }
    
    private func constraintModalQuestionView(_ size: CGSize) {
        containerView.addSubview(modalQuestionView)
        modalQuestionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modalQuestionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalQuestionView.widthAnchor.constraint(equalToConstant: computeDialogWidth(size)),
            
            containerView.topAnchor.constraint(lessThanOrEqualTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: modalQuestionView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: modalQuestionView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: modalQuestionView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: modalQuestionView.trailingAnchor)
        ])
        centerScrollContentIfNeeded(size)
    }
    
    private func centerScrollContentIfNeeded(_ size: CGSize) {
        containerView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
        
        if containerView.frame.height < size.height {
            let centerOffsetX = (modalQuestionView.frame.size.width - size.width) / 2
            let centerOffsetY = (modalQuestionView.frame.size.height - size.height) / 2
            let centerPoint = CGPoint(x: centerOffsetX, y: centerOffsetY)
            self.scrollView.setContentOffset(centerPoint, animated: false)
        } 
    }
    
    private func computeFrameForDialog(_ size: CGSize) -> CGRect {
        return CGRect(x: 0, y: 0, width: computeDialogWidth(size), height: 180)
    }
    
    private func computeDialogWidth(_ size: CGSize) -> CGFloat {
        let minWidth = size.width - 30
        if minWidth > maxWidth {
            return maxWidth
        }
        return size.width - 30
    }
    
    
}

extension DialogModalViewController: SurveyViewDelegate {
    
    func closeClicked() {
        dismiss(animated: true, completion: nil)
    }
    
}
