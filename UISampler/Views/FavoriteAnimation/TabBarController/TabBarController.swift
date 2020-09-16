//
//  TabBarController.swift
//  UISampler
//
//  Created by okudera on 2020/09/16.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    class func instance() -> TabBarController {
        let viewController: TabBarController = .instantiate()
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarItem.setupAllItems(self.tabBar)
    }
}

extension TabBarController {

    enum TabBarItem: Int, CaseIterable {
        case home
        case bookshelf

        var title: String {
            switch self {
            case .home:
                return "ホーム"
            case .bookshelf:
                return "本棚"
            }
        }

        var image: UIImage {
            switch self {
            case .home:
                return UIImage(named: "home")!
            case .bookshelf:
                return UIImage(named: "bookshelf")!
            }
        }

        /// UITabBarにタイトル、イメージ、タグをセット
        static func setupAllItems(_ tabBar: UITabBar) {
            self.allCases.forEach {
                let tabBarItem = tabBar.items?[$0.rawValue]
                tabBarItem?.title = $0.title
                tabBarItem?.image = $0.image
                tabBarItem?.tag = $0.rawValue
            }
        }

        /// 現在配置されているUITabBarから各タブのUIImageViewを取得
        static func allTabBarImages(_ tabBar: UITabBar) -> [UIImageView] {
            let images = tabBar
                .findViews(subclassOf: UIImageView.self)
                .filter { !$0.isKind(of: NSClassFromString("_UIVisualEffectImageView")!) }
            return images
        }
    }
}

extension TabBarController {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tabBarItem = TabBarItem(rawValue: item.tag) {
            self.animateTabImage(tabBarItem: tabBarItem)
        }
    }
}

extension TabBarController {

    func animateTabImage(tabBarItem: TabBarItem) {

        let imageViews = TabBarItem.allTabBarImages(self.tabBar)
        print("TabBar imageViews", imageViews)

        // アイコン画像をバウンドさせるアニメーション
        UIView.animateKeyframes(withDuration: 0.16, delay: 0.0, options: [.autoreverse], animations: {
            // 1.2倍まで拡大するアニメーション
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0, animations: {
                imageViews[tabBarItem.rawValue].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
            // 等倍まで縮小するアニメーション
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1.0, animations: {
                imageViews[tabBarItem.rawValue].transform = CGAffineTransform.identity
            })
        })
    }
}
