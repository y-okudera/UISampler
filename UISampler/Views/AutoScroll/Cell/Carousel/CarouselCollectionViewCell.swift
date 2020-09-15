//
//  CarouselCollectionViewCell.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import InfiniteLayout

final class CarouselCollectionViewCell: UICollectionViewCell, AutoScrollableCarousel {

    @IBOutlet weak var collectionView: InfiniteCollectionView!

    var autoScrollTimer = Timer()

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.register(cellType: CarouselItemCollectionViewCell.self)
    }

    func configure(dataSource: UICollectionViewDelegate & UICollectionViewDataSource, scrollDirection: UICollectionView.ScrollDirection, autoScrollDirection: AutoScrollDirection) {

        // collectionViewのスクロール方向を設定
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
        }

        // スクロールバーを非表示
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false

        // Delegate & DataSourceを設定
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = dataSource

        // collectionViewのタップの遅延を無くす
        self.collectionView.delaysContentTouches = false

        // 自動スクローをを開始
        self.startAutoScroll(direction: autoScrollDirection)
    }

}
