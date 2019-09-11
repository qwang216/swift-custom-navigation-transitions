//
//  AnimatedNavigationController.swift
//  TransitionAnimation
//
//  Created by Cary Zhou on 9/11/19.
//  Copyright © 2019 Cary Zhou. All rights reserved.
//

import UIKit

class AnimatedNavigationController: UINavigationController {

    enum AnimationStyle {
        case native, fade
    }

    var animationStyle: AnimationStyle = .native

    convenience init(rootViewController: UIViewController, defaultAnimation: AnimationStyle = .native) {
        self.init(rootViewController: rootViewController)
        animationStyle = defaultAnimation
        delegate = self
    }

    deinit {
        print("☀️ deinit AnimatedNavigationController")
    }
}

extension AnimatedNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard animationStyle != .native else { return nil }

        switch operation {
        case .push, .pop:
            return FadeAnimator(operation: operation)
        default:
            return nil
        }
    }

    func pushViewController(_ viewController: UIViewController, using style: AnimationStyle) {
        let prevStyle = animationStyle
        animationStyle = style
        super.pushViewController(viewController, animated: true)
        animationStyle = prevStyle
    }

    func popViewController(_ viewController: UIViewController, using style: AnimationStyle) {
        let prevStyle = animationStyle
        animationStyle = style
        super.popViewController(animated: true)
        animationStyle = prevStyle
    }
}
