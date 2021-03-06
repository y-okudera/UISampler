//
//  SlideInFromRightTransition.swift
//  UISampler
//
//  Created by okudera on 2020/10/26.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

/// Push / Pop
struct SlideInFromRightTransition: AlertTransitionAnimation {

    /// 右端からスライドイン
    static func show(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        container.addSubview(toView)
        toView.transform = CGAffineTransform(translationX: transitionContext.containerView.frame.width, y: 0)

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseIn], animations: {
            toView.transform = .identity
        }, completion: { _ in
            toView.transform = .identity
            transitionContext.completeTransition(true)
        })
    }

    /// 右端へスライドアウト
    static func hide(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        container.addSubview(fromView)
        fromView.transform = .identity

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseOut], animations: {
            fromView.transform = CGAffineTransform(translationX: fromView.superview!.frame.width, y: 0)
        }, completion: { _ in
            fromView.transform = .identity
            transitionContext.completeTransition(true)
        })
    }
}
