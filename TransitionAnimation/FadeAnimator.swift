//
//  FadeAnimator.swift
//  TransitionAnimation
//
//  Created by Cary Zhou on 9/11/19.
//  Copyright © 2019 Cary Zhou. All rights reserved.
//

import UIKit

public class FadeAnimator: NSObject {
    let operation: UINavigationController.Operation
    let duration: TimeInterval

    init(operation: UINavigationController.Operation, duration: TimeInterval = 0.3) {
        self.operation = operation
        self.duration = duration
    }
}

extension FadeAnimator: UIViewControllerAnimatedTransitioning {

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else { return }

        let duration = self.transitionDuration(using: transitionContext)

        switch operation {
        case .push:
            transitionContext.containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                toViewController.view.alpha = 1
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        case .pop:
            transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            UIView.animate(withDuration: duration, animations: {
                fromViewController.view.alpha = 0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        default:
            return
        }
    }

}
