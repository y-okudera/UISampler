//
//  CarouselItemCollectionViewCell.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

/// カルーセルの要素のセル
final class CarouselItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

    private(set) var parentIndexPath: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }

    func configure(parentIndexPath: IndexPath, image: UIImage) {
        self.parentIndexPath = parentIndexPath
        self.imageView.image = image
    }
}
