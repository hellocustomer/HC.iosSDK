//
//  AbstractBottomSheetViewController.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 24/07/2021.
//

import Foundation
import UIKit

class AbstractBottomSheetViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
        
    let maxDimmedAlpha: CGFloat = 0.7
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
        
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    open var defaultHeight: CGFloat = 150
    lazy var dismissibleHeight: CGFloat = {
        defaultHeight / 3 * 2
    }()
    lazy var currentContainerHeight: CGFloat = {
        return defaultHeight
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    private func setupView() {
        view.backgroundColor = .clear
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < defaultHeight {
                // containerViewHeightConstraint?.constant = newHeight
                self.containerViewBottomConstraint?.constant = self.defaultHeight - newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            } else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
                animatePresentContainer()
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    private func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    open func setupConstraints() {
        view.addSubview(dimmedView)

        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView
            .bottomAnchor
            .constraint(
                equalTo: view.bottomAnchor,
                constant: defaultHeight
            )
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
}
