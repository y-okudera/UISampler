//
//  HomeViewController+Animation.swift
//  UISampler
//
//  Created by okudera on 2020/09/16.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension HomeViewController {

    func removeFavorite() {

        guard let tabBarController = self.tabBarController as? TabBarController else {
            return
        }

        guard let bookshelfTabItem = tabBarController.tabBar.items?[TabBarController.TabBarItem.bookshelf.rawValue] else {
            return
        }

        if let badgeValue = bookshelfTabItem.badgeValue, let intValue = Int(badgeValue) {
            let newValue = intValue - 1
            bookshelfTabItem.badgeValue = newValue > 0 ? "\(newValue)" : nil
        }
        else {
            bookshelfTabItem.badgeValue = nil
        }
    }

    func addFavoriteAnimation() {

        guard let tabBarController = self.tabBarController as? TabBarController else {
            return
        }

        // 各タブのUIImageViewを取得
        let imageViews = TabBarController.TabBarItem.allTabBarImages(tabBarController.tabBar)
        // 本棚タブのUIImageView
        let bookshelfTabImageView = imageViews[TabBarController.TabBarItem.bookshelf.rawValue]

        guard let convertedFrame = bookshelfTabImageView.superview?.superview?.convert(bookshelfTabImageView.frame, to: tabBarController.tabBar) else {
            return
        }
        let xValue = convertedFrame.midX - self.favoritedImageView.frame.midX
        let yValue = self.favoritedImageViewBottomConstraint.constant + tabBarController.tabBar.frame.height

        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [], animations: { [weak self] in
            // サムネイルを拡大しながら表示するアニメーション
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: { [weak self] in
                self?.favoritedImageView.transform = .identity
            })
            // サムネイルを移動しながら非表示にするアニメーション
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1.0, animations: { [weak self] in
                guard let `self` = self else {
                    return
                }
                var transform = self.favoritedImageView.transform
                transform = transform.translatedBy(x: xValue, y: yValue)
                transform = transform.scaledBy(x: 0.0, y: 0.0)
                self.favoritedImageView.transform = transform
            })

            // 本棚タブのイメージの拡大アニメーションと縮小アニメーションのセットを2回実行する
            self?.tabImageAnimation(tabImageView: bookshelfTabImageView, relativeStartTime: 0.8)
            self?.tabImageAnimation(tabImageView: bookshelfTabImageView, relativeStartTime: 0.9)

        }, completion: { [weak self] finished in
            self?.favoritedImageView.transform = .init(scaleX: 0, y: 0)

            if let bookshelfTabItem = tabBarController.tabBar.items?[TabBarController.TabBarItem.bookshelf.rawValue] {

                // 数字のbadgeを付ける
                if let badgeValue = bookshelfTabItem.badgeValue, let intValue = Int(badgeValue) {
                    bookshelfTabItem.badgeValue = "\(intValue + 1)"
                }
                else {
                    // bookshelfTabItem.badgeValueがnilの場合はbadgeが付いてないので、1を設定
                    bookshelfTabItem.badgeValue = "1"
                }

                // 赤丸のbadgeを付ける場合は以下
//                bookshelfTabItem.badgeValue = ""
            }
        })
    }

    private func tabImageAnimation(tabImageView: UIImageView, relativeStartTime: Double) {

        let expandingTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        let shrinkingTransform = CGAffineTransform.identity

        // 本棚タブのイメージを1.2倍まで拡大するアニメーション
        UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: relativeStartTime + 0.05, animations: {
            tabImageView.transform = expandingTransform
        })
        // 本棚タブのイメージを等倍まで縮小するアニメーション
        UIView.addKeyframe(withRelativeStartTime: relativeStartTime + 0.05, relativeDuration: relativeStartTime + 0.1, animations: {
            tabImageView.transform = shrinkingTransform
        })
    }
}
