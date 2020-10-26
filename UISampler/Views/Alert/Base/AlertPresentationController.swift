//
//  AlertPresentationController.swift
//  UISampler
//
//  Created by okudera on 2020/10/24.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class AlertPresentationController: UIPresentationController {

    /// アラートの縦横比
    private let aspectRatio = (width: CGFloat(343), height: CGFloat(312))

    /// 遷移元を覆う半透明のビュー
    private var overlay: UIView!

    override var shouldRemovePresentersView: Bool {
        return false
    }

    // 表示の遷移開始前
    override func presentationTransitionWillBegin() {

        self.addOverlay()

        // 遷移処理を実行
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlay.alpha = 0.5
        })
    }

    // 非表示の遷移開始前
    override func dismissalTransitionWillBegin() {

        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlay.alpha = 0.0
        })
    }

    // 非表示の遷移後
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }

    // 子コンテナのサイズ
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        // アラートの幅が収まらない場合は、アラートの幅をparentSize.width * 0.8にする
        let width = (parentSize.width < aspectRatio.width) ? parentSize.width * 0.8 : aspectRatio.width
        return CGSize(width: width, height: width * (self.aspectRatio.height / self.aspectRatio.width))
    }

    // 呼び出すVCのframe
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = self.containerView!.bounds
        presentedViewFrame.size = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = (containerBounds.size.width - presentedViewFrame.size.width) / 2
        presentedViewFrame.origin.y = (containerBounds.size.height - presentedViewFrame.size.height) / 2
        return presentedViewFrame
    }

    // レイアウト開始前
    override func containerViewWillLayoutSubviews() {
        overlay.frame = self.containerView!.bounds
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }

    // レイアウト後
    override func containerViewDidLayoutSubviews() {

    }
}

// MARK: - Selector
extension AlertPresentationController {

    @objc func tappedOverlay() {
        self.presentedViewController.dismiss(animated: true)
    }
}

extension AlertPresentationController {

    private func addOverlay() {
        let container = self.containerView!
        self.overlay = UIView(frame: container.bounds)
        self.overlay.gestureRecognizers = [
            UITapGestureRecognizer(target: self, action: #selector(AlertPresentationController.tappedOverlay))
        ]
        self.overlay.backgroundColor = .black
        self.overlay.alpha = 0.0
        container.insertSubview(self.overlay, at: 0)
    }
}
