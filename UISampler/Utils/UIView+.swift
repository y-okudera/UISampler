//
//  UIView+.swift
//  UISampler
//
//  Created by okudera on 2020/09/16.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

extension UIView {

    /// 枠線の色
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    /// 枠線のWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// 角丸設定
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /// xibでviewを実装する場合の初期化処理
    func loadNib() {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }

    /// 再帰的にサブビューを取得する
    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }

    /// 再帰的にサブビューを取得する（型指定あり）
    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }
}
