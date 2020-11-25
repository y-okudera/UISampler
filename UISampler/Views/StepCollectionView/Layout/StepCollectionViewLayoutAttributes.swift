//
//  StepCollectionViewLayoutAttributes.swift
//  UISampler
//
//  Created by okudera on 2020/09/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class StepCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var photoHeight = CGFloat(0.0)

    override func copy(with zone: NSZone?) -> Any {
        guard let copy = super.copy(with: zone) as? StepCollectionViewLayoutAttributes else {
            fatalError("copy failed.")
        }
        copy.photoHeight = photoHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {

        if let attributes = object as? StepCollectionViewLayoutAttributes {

            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}
