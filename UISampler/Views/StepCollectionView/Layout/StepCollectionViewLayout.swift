//
//  StepCollectionViewLayout.swift
//  UISampler
//
//  Created by okudera on 2020/09/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

protocol StepCollectionViewLayoutDelegate: class {

    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForCaptionAndCommentAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat
}

final class StepCollectionViewLayout: UICollectionViewLayout {

    weak var delegate: StepCollectionViewLayoutDelegate?
    var numberOfColumns = 2
    var cellPadding = CGFloat(8.0)

    var cache = [StepCollectionViewLayoutAttributes]()

    var contentHeight = CGFloat(0.0)
    var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }

    override class var layoutAttributesClass: AnyClass {
        return StepCollectionViewLayoutAttributes.self
    }

    /// レイアウトの事前準備
    override func prepare() {

        super.prepare()

        guard self.cache.isEmpty else {
            return
        }

        guard let collectionView = collectionView else {
            return
        }

        let columnWidth = self.contentWidth / CGFloat(self.numberOfColumns)
        var offsetX = [CGFloat]()

        for column in 0 ..< self.numberOfColumns {
            let offset = CGFloat(column) * columnWidth
            offsetX.append(offset)
        }

        var column = 0
        var offsetY = [CGFloat](repeating: 0, count: self.numberOfColumns)

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {


            let indexPath = IndexPath(item: item, section: 0)

            let width = columnWidth - self.cellPadding * 2
            let photoHeight = self.delegate?.collectionView(collectionView: collectionView, heightForPhotoAtIndexPath: indexPath, width: width)

            let labelHeight = self.delegate?.collectionView(collectionView: collectionView, heightForCaptionAndCommentAtIndexPath: indexPath, width: width)

            let height = self.cellPadding + photoHeight! + labelHeight!

            let frame = CGRect(x: offsetX[column],
                               y: offsetY[column],
                               width: columnWidth,
                               height: height)

            let insetFrame = frame.insetBy(dx: self.cellPadding, dy: self.cellPadding)

            let attributes = StepCollectionViewLayoutAttributes(forCellWith: indexPath)

            attributes.photoHeight = photoHeight!
            attributes.frame = insetFrame
            self.cache.append(attributes)

            self.contentHeight = max(self.contentHeight, frame.maxY)
            offsetY[column] = offsetY[column] + height

            column = column >= self.numberOfColumns - 1 ? 0 : column + 1
        }
    }

    /// コンテンツサイズ
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }

    /// 表示する要素
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in self.cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
