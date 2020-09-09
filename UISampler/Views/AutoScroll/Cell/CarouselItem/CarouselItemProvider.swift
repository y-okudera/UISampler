//
//  CarouselItemProvider.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

protocol CarouselItemProviderCompatible {

    associatedtype Item

    var parentIndexPath: IndexPath! { get }
    var items: [Item] { get }
    func set(parentIndexPath: IndexPath)
    func set(items: [UIImage])
    func initialPosition(collectionView: UICollectionView)
}

final class CarouselItemProvider: NSObject, CarouselItemProviderCompatible {

    private let infiniteSize = 1_000_000

    var parentIndexPath: IndexPath!
    var items = [UIImage]()

    func set(parentIndexPath: IndexPath) {
        self.parentIndexPath = parentIndexPath
    }

    func set(items: [UIImage]) {
        self.items = items
    }

    func initialPosition(collectionView: UICollectionView) {
        let midIndexPath = IndexPath(row: infiniteSize / 2, section: 0)

        guard collectionView.numberOfItems(inSection: 0) > midIndexPath.row else {
            return
        }
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            switch layout.scrollDirection {
            case .horizontal:
                collectionView.scrollToItem(at: midIndexPath, at: .centeredHorizontally, animated: false)
            case .vertical:
                collectionView.scrollToItem(at: midIndexPath, at: .centeredVertically, animated: false)
            @unknown default:
                break
            }
        }
    }
}

extension CarouselItemProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.infiniteSize
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: CarouselItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.label.text = "\(indexPath.row)"
        cell.configure(parentIndexPath: self.parentIndexPath, image: self.items[indexPath.row % self.items.count])
        return cell
    }
}

extension CarouselItemProvider: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CarouselItemCollectionViewCell {
            print("CarouselItemProvider didSelectItemAt", indexPath, "Carousel index", String(describing: cell.parentIndexPath))
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
