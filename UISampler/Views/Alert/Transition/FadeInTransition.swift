//
//  FadeInTransition.swift
//  UISampler
//
//  Created by okudera on 2020/10/26.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

/// fadeIn / fadeOut
struct FadeInTransition: AlertTransitionAnimation {

    /// フェードイン
    static func show(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        container.addSubview(toView)
        toView.alpha = 0.0

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseIn], animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            toView.alpha = 1.0
            transitionContext.completeTransition(true)
        })
    }

    /// フェードアウト
    static func hide(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        container.addSubview(fromView)
        fromView.alpha = 1.0

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseOut], animations: {
            fromView.alpha = 0.0
        }, completion: { _ in
            fromView.alpha = 1.0
            transitionContext.completeTransition(true)
        })
    }
}
