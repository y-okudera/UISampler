//
//  LeftSideHeaderView.swift
//  UISampler
//
//  Created by okudera on 2020/09/17.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class LeftSideHeaderView: UIView {

    @IBOutlet private weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    func configure(image: UIImage?) {
        self.imageView.image = image
    }
}

extension LeftSideHeaderView {

    private func loadNib() {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
