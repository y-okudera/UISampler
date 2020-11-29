//
//  PhotoCollectionViewCell.swift
//  UISampler
//
//  Created by okudera on 2020/09/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }

    func configure(photo: Photo) {
        self.imageView.image = photo.image
        self.captionLabel.text = photo.caption
        self.commentLabel.text = photo.comment

        self.layer.cornerRadius = self.frame.size.width * 0.1
        self.clipsToBounds = true
    }
}
