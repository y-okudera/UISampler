//
//  CarouselProvider.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class CarouselProvider: NSObject {

    private(set) var itemDataSources: [CarouselItemProvider]!

    func set(itemDataSources: [CarouselItemProvider]) {
        self.itemDataSources = itemDataSources
    }
}

extension CarouselProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemDataSources.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: CarouselCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if indexPath.row % 2 == 0 {
            cell.configure(dataSource: self.itemDataSources[indexPath.row], scrollDirection: .horizontal, autoScrollDirection: .left)
        }
        else {
            cell.configure(dataSource: self.itemDataSources[indexPath.row], scrollDirection: .horizontal, autoScrollDirection: .right)
        }
        self.itemDataSources[indexPath.row].set(parentIndexPath: indexPath)
        self.itemDataSources[indexPath.row].initialPosition(collectionView: cell.collectionView)
        return cell
    }
}

extension CarouselProvider: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("CarouselProvider didSelectItemAt", indexPath)
    }
}

extension CarouselProvider: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 70.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
