//
//  UICollectionView+.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
}
