//
//  AnimatedNavigationController.swift
//  TransitionAnimation
//
//  Created by Cary Zhou on 9/11/19.
//  Copyright © 2019 Cary Zhou. All rights reserved.
//

import UIKit

enum AnimationStyle {
    case native, fade
}

class AnimatedNavigationController: UINavigationController, AnimatedNavigationable {

    var animationStyle: AnimationStyle = .native

    convenience init(rootViewController: UIViewController, defaultAnimation: AnimationStyle = .native) {
        self.init(rootViewController: rootViewController)
        animationStyle = defaultAnimation
        delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return setTransitionAnimationOn(operation)
    }

}

protocol AnimatedNavigationable: NSObject, UINavigationControllerDelegate {
    var animationStyle: AnimationStyle { set get }
    func pushViewController(_ viewController: UIViewController, using style: AnimationStyle)
    func popViewController(_ viewController: UIViewController, using style: AnimationStyle)
    func setTransitionAnimationOn(_ operation: UINavigationController.Operation) -> UIViewControllerAnimatedTransitioning?
}

extension AnimatedNavigationable where Self: UINavigationController {

    func pushViewController(_ viewController: UIViewController, using style: AnimationStyle) {
        let prevStyle = animationStyle
        animationStyle = style
        pushViewController(viewController, animated: true)
        animationStyle = prevStyle
    }

    func popViewController(_ viewController: UIViewController, using style: AnimationStyle) {
        let prevStyle = animationStyle
        animationStyle = style
        popViewController(animated: true)
        animationStyle = prevStyle
    }

    func setTransitionAnimationOn(_ operation: UINavigationController.Operation) -> UIViewControllerAnimatedTransitioning? {
        guard animationStyle != .native else { return nil }

        switch operation {
        case .push, .pop:
            return FadeAnimator(operation: operation)
        default:
            return nil
        }
    }

}

