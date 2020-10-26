//
//  ScaledUpTransition.swift
//  UISampler
//
//  Created by okudera on 2020/10/26.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

// 拡大して表示 / 縮小して非表示
struct ScaledUpTransition: AlertTransitionAnimation {

    /// 拡大して表示
    static func show(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        container.addSubview(toView)
        toView.transform = CGAffineTransform(scaleX: 0, y: 0)

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.85, animations: {
                toView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 1.0, animations: {
                toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })

        }, completion: { _ in
            toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            transitionContext.completeTransition(true)
        })
    }

    /// 縮小して非表示
    static func hide(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        container.addSubview(fromView)
        fromView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            })

        }, completion: { _ in
            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            transitionContext.completeTransition(true)
        })
    }
}
