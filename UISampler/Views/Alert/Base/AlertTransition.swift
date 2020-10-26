//
//  AlertTransition.swift
//  UISampler
//
//  Created by okudera on 2020/10/26.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

protocol AlertTransitionAnimation {
    static func show(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval)
    static func hide(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval)
}

enum AlertTransitionType: Int {
    case fadeIn
    case scaledUp
    case slideInFromBottom
    case slideInFromLeft
    case slideInFromRight
    case slideInFromTop

    var defaultDuration: TimeInterval {
        switch self {
        case .fadeIn:
            return 0.5
        case .scaledUp:
            return 0.5
        case .slideInFromBottom:
            return 0.7
        case .slideInFromLeft:
            return 0.5
        case .slideInFromRight:
            return 0.5
        case .slideInFromTop:
            return 0.7
        }
    }

    func presentTransition(using transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        switch self {
        case .fadeIn:
            FadeInTransition.show(transitionContext, duration: duration)
        case .scaledUp:
            ScaledUpTransition.show(transitionContext, duration: duration)
        case .slideInFromBottom:
            SlideInFromBottomTransition.show(transitionContext, duration: duration)
        case .slideInFromLeft:
            SlideInFromLeftTransition.show(transitionContext, duration: duration)
        case .slideInFromRight:
            SlideInFromRightTransition.show(transitionContext, duration: duration)
        case .slideInFromTop:
            SlideInFromTopTransition.show(transitionContext, duration: duration)
        }
    }

    func dismissTransition(using transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        switch self {
        case .fadeIn:
            FadeInTransition.hide(transitionContext, duration: duration)
        case .scaledUp:
            ScaledUpTransition.hide(transitionContext, duration: duration)
        case .slideInFromBottom:
            SlideInFromBottomTransition.hide(transitionContext, duration: duration)
        case .slideInFromLeft:
            SlideInFromLeftTransition.hide(transitionContext, duration: duration)
        case .slideInFromRight:
            SlideInFromRightTransition.hide(transitionContext, duration: duration)
        case .slideInFromTop:
            SlideInFromTopTransition.hide(transitionContext, duration: duration)
        }
    }
}

final class AlertTransition: NSObject {

    private var willShow: Bool = true
    private var transitionType: AlertTransitionType = .slideInFromRight
    private var duration: TimeInterval?

    convenience init(willShow: Bool, transitionType: AlertTransitionType, duration: TimeInterval? = nil) {
        self.init()
        self.willShow = willShow
        self.transitionType = transitionType
        self.duration = duration
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension AlertTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration ?? self.transitionType.defaultDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = self.transitionDuration(using: transitionContext)
        if willShow {
            self.transitionType.presentTransition(using: transitionContext, duration: duration)
        }
        else {
            self.transitionType.dismissTransition(using: transitionContext, duration: duration)
        }
    }
}
