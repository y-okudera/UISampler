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
        self.loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.loadNib()
    }

    func configure(image: UIImage?) {
        self.imageView.image = image
    }
}
