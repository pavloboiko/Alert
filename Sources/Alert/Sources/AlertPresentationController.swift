//
//  AlertPresentationController.swift
//  Alert
//
//  Created by Ursus on 10/22/20.
//  Copyright © 2020 Aisberg LLC. All rights reserved.
//

import UIKit

class AlertPresentationController: UIPresentationController {
    
    private func decoratePresentedView(_ view: UIView) {
        let motion1 = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        motion1.maximumRelativeValue = 10.0
        motion1.minimumRelativeValue = -10.0
        
        let motion2 = UIInterpolatingMotionEffect(keyPath: "center.y", type:.tiltAlongVerticalAxis)
        motion2.maximumRelativeValue = 10.0
        motion2.minimumRelativeValue = -10.0
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [motion1, motion2]
        view.addMotionEffect(group)
    }
    
    override func presentationTransitionWillBegin() {
        guard
            let presentedView = presentedView,
            let containerView = containerView,
            let presentingView = presentingViewController.view,
            let coordinator = presentingViewController.transitionCoordinator else { return }
        
        decoratePresentedView(presentedView)
        
        let shadowView = UIView(frame: containerView.bounds)
        shadowView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        shadowView.alpha = 0
        shadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.insertSubview(shadowView, at: 0)
        
        coordinator.animate(alongsideTransition: { _ in
            shadowView.alpha = 1
        }) { _ in
            presentingView.tintAdjustmentMode = .dimmed
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator,
            let presentingView = presentingViewController.view,
            let containerView = containerView else { return }
        
        let shadowView = containerView.subviews[0]
        
        coordinator.animate(alongsideTransition: { _ in
            shadowView.alpha = 0
        }) { _ in
            presentingView.tintAdjustmentMode = .automatic
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let presentedView = presentedView, let containerView = containerView else { return .zero }
        presentedView.center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
        return presentedView.frame.integral
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let presentedView = presentedView else { return }
        presentedView.autoresizingMask = [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
        presentedView.translatesAutoresizingMaskIntoConstraints = true
    }
}
