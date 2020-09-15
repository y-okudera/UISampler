//
//  AutoScrollViewController.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class AutoScrollViewController: UIViewController {

    private var itemDataSources = [CarouselItemProvider]()
    private var carouselItemProviders = [CarouselItemProvider]()

    @IBOutlet weak var collectionView: UICollectionView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
            newValue.register(cellType: CarouselCollectionViewCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "AutoScrollCarousel"
        self.setupCarousel()
    }

    private func setupCarousel() {

        // collectionViewのタップの遅延を無くす
        self.collectionView.delaysContentTouches = false

        // カルーセルを2段用意し、テスト画像をセット
        self.carouselItemProviders = [.init(), .init()]
        self.carouselItemProviders.forEach {
            $0.set(items: [
                UIImage(named: "img1")!,
                UIImage(named: "img2")!,
                UIImage(named: "img3")!,
                UIImage(named: "img4")!,
                UIImage(named: "img5")!,
            ])
        }

        self.itemDataSources = self.carouselItemProviders
    }
}

// MARK: - UICollectionView

extension AutoScrollViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemDataSources.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: CarouselCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(dataSource: self.itemDataSources[indexPath.row], scrollDirection: .horizontal, autoScrollDirection: .left)
        self.itemDataSources[indexPath.row].set(parentIndexPath: indexPath)
        return cell
    }
}

extension AutoScrollViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 70.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: .zero, left: 8.0, bottom: .zero, right: 8.0)
    }
}
