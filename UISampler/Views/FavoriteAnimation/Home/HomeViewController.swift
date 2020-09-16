//
//  HomeViewController.swift
//  UISampler
//
//  Created by okudera on 2020/09/16.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet weak var favoritedImageView: UIImageView! {
        willSet {
            // 初期状態はscale0
            newValue.transform = .init(scaleX: 0, y: 0)

        }
    }
    @IBOutlet weak var favoritedImageViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.navigationItem.title = "FavoriteAnimation"
        self.favoritedImageView.image = self.thumbnailImageView.image
    }
    
    @IBAction func tappedLikeButton(_ sender: UIButton) {

        if sender.isSelected {
            self.removeFavorite()
        }
        else {
            self.addFavoriteAnimation()
        }
        sender.isSelected.toggle()
    }
}
