//
//  AutoScrollableCarousel.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import InfiniteLayout

enum AutoScrollDirection {
    case up, down, left, right
}

protocol AutoScrollableCarousel: AnyObject {

    var collectionView: InfiniteCollectionView! { get }
    var autoScrollTimer: Timer { get set }

    /// 自動スクロールを開始する
    func startAutoScroll(direction: AutoScrollDirection, distance: CGFloat, duration: TimeInterval)
    /// 自動スクロールを停止する
    func stopAutoScroll()
}

extension AutoScrollableCarousel {

    // 自動スクロールを開始する
    func startAutoScroll(direction: AutoScrollDirection, distance: CGFloat = 20, duration: TimeInterval = 1.0) {

        self.autoScrollTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true, block: { [weak self] _ in
            guard let `self` = self else { return }

            var contentOffset = CGPoint.zero
            switch direction {
            case .up:
                contentOffset = .init(x: .zero, y: self.collectionView.contentOffset.y + distance)
            case .down:
                contentOffset = .init(x: .zero, y: self.collectionView.contentOffset.y - distance)
            case .left:
                contentOffset = .init(x: self.collectionView.contentOffset.x + distance, y: .zero)
            case .right:
                contentOffset = .init(x: self.collectionView.contentOffset.x - distance, y: .zero)
            }
            UIView.animate(withDuration: duration, delay: .zero, options: [.curveLinear, .allowUserInteraction], animations: { [weak self] in
                guard let `self` = self else { return }
                self.collectionView.setContentOffset(contentOffset, animated: false)
            })
        })
    }

    // 自動スクロールを停止する
    func stopAutoScroll() {
        if self.autoScrollTimer.isValid {
            self.autoScrollTimer.invalidate()
        }
    }
}
