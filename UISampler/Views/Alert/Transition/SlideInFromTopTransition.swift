//
//  SlideInFromTopTransition.swift
//  UISampler
//
//  Created by okudera on 2020/10/26.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

/// Present / Dismissの逆
struct SlideInFromTopTransition: AlertTransitionAnimation {

    /// 上端からスライドイン
    static func show(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        container.addSubview(toView)
        toView.transform = CGAffineTransform(translationX: 0, y: -transitionContext.containerView.frame.height)

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseIn], animations: {
            toView.transform = .identity
        }, completion: { _ in
            toView.transform = .identity
            transitionContext.completeTransition(true)
        })
    }

    /// 上端へスライドアウト
    static func hide(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        container.addSubview(fromView)
        fromView.transform = .identity

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseOut], animations: {
            fromView.transform = CGAffineTransform(translationX: 0, y: -fromView.superview!.frame.height)
        }, completion: { _ in
            fromView.transform = .identity
            transitionContext.completeTransition(true)
        })
    }
}
