//
//  CarouselCollectionViewCell.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell, AutoScrollableCarousel {

    @IBOutlet weak var collectionView: UICollectionView!

    var autoScrollTimer = Timer()

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.register(cellType: CarouselItemCollectionViewCell.self)
    }

    func configure(dataSource: UICollectionViewDelegate & UICollectionViewDataSource, scrollDirection: UICollectionView.ScrollDirection, autoScrollDirection: AutoScrollDirection) {

        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
        }
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false

        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = dataSource
        self.collectionView.delaysContentTouches = false

        self.startAutoScroll(direction: autoScrollDirection)
    }

}
