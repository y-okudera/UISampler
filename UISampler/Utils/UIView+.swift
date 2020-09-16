//
//  UIView+.swift
//  UISampler
//
//  Created by okudera on 2020/09/16.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension UIView {
    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }

    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }
}
