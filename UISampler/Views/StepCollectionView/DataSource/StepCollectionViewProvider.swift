//
//  StepCollectionViewProvider.swift
//  UISampler
//
//  Created by okudera on 2020/09/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import AVFoundation
import UIKit

final class StepCollectionViewProvider: NSObject {

    var photos: [Photo] = []

    func add(photos: [Photo]) {
        self.photos = photos
    }

    func find(index: Int) -> Photo{
        return photos[index]
    }
}

// MARK: - UICollectionViewDataSource
extension StepCollectionViewProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoListCell is nil.")
        }
        cell.configure(photo: photos[indexPath.row])
        return cell
    }
}

// MARK:- PinterestLayoutDelegate
extension StepCollectionViewProvider: StepCollectionViewLayoutDelegate {

    struct FontSize {
        static let caption = CGFloat(14.0)
        static let comment = CGFloat(11.0)
    }

    struct Padding {
        static let height = CGFloat(16.0)
    }

    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {

        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: CGFloat(MAXFLOAT)
        )
        guard let image = photos[indexPath.row].image else {
            return CGFloat(0.0)
        }

        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.size.height
    }

    func collectionView(collectionView: UICollectionView, heightForCaptionAndCommentAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {

        let photo = photos[indexPath.item]

        let captionHeight = photo.heightForCaption(
            font: .systemFont(ofSize: FontSize.caption),
            width: width
        )

        let commentHeight = photo.heightForComment(
            font: .systemFont(ofSize: FontSize.comment),
            width: width
        )

        return Padding.height + captionHeight + commentHeight + Padding.height
    }
}
