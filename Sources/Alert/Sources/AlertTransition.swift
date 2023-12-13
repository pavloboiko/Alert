//
//  AlertTransition.swift
//  Alert
//
//  Created by Ursus on 10/22/20.
//  Copyright © 2020 Aisberg LLC. All rights reserved.
//

import UIKit
import QuartzCore

public class AlertTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    var transitionDuration: TimeInterval = 0.25
    
    var isPresenting = false
    
    var onPresent: (() -> Void)?
    
    var onDismiss: (() -> Void)?
    
    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        
        return AlertPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AlertTransition {
    
    public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension AlertTransition: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        if isPresenting, let toView = toView {
            containerView.addSubview(toView)
            
            onPresent?()
            
            let offset = UIScreen.main.bounds.height / 2 + toView.bounds.height / 2
            toView.transform = CGAffineTransform(translationX: 0, y: -offset)
            
            UIView.animate(withDuration: transitionDuration,
                           delay: 0.0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1.3,
                           options: [],
                           animations: {
                toView.transform = .identity
            }) { _ in
                transitionContext.completeTransition(true)
            }            
        } else if !isPresenting, let fromView = fromView {
            onDismiss?()
            
            UIView.animate(withDuration: transitionDuration, animations: {
                fromView.alpha = 0
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
    }
}
