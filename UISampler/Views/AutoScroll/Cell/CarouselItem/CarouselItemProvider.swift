//
//  CarouselItemProvider.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import InfiniteLayout
import UIKit

protocol CarouselItemProviderCompatible {

    associatedtype Item

    var parentIndexPath: IndexPath! { get }
    var items: [Item] { get }
    func set(parentIndexPath: IndexPath)
    func set(items: [Item])
}

final class CarouselItemProvider: NSObject, CarouselItemProviderCompatible {

    var parentIndexPath: IndexPath!
    var items = [UIImage]()

    func set(parentIndexPath: IndexPath) {
        self.parentIndexPath = parentIndexPath
    }

    func set(items: [UIImage]) {
        self.items = items
    }
}

extension CarouselItemProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: CarouselItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if let infiniteCollectionView = collectionView as? InfiniteCollectionView {
            let realIndexPath = infiniteCollectionView.indexPath(from: indexPath)
            cell.configure(parentIndexPath: self.parentIndexPath, image: self.items[realIndexPath.row])
            return cell
        }
        cell.configure(parentIndexPath: self.parentIndexPath, image: self.items[indexPath.row % self.items.count])
        return cell
    }
}

extension CarouselItemProvider: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let infiniteCollectionView = collectionView as? InfiniteCollectionView,
            let cell = infiniteCollectionView.cellForItem(at: indexPath) as? CarouselItemCollectionViewCell {
            let realIndexPath = infiniteCollectionView.indexPath(from: indexPath)
            print("CarouselItem didSelectItemAt", realIndexPath, "Carousel index", String(describing: cell.parentIndexPath))
        }
    }
}

extension CarouselItemProvider: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80.0, height: 70.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
