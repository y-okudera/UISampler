//
//  AutoScrollViewController.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class AutoScrollViewController: UIViewController {

    private let carouselProvider = CarouselProvider()
    private var carouselItemProviders = [CarouselItemProvider]()

    @IBOutlet weak var collectionView: UICollectionView! {
        willSet {
            newValue.dataSource = self.carouselProvider
            newValue.delegate = self.carouselProvider
            newValue.register(cellType: CarouselCollectionViewCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.carouselItemProviders = [.init(), .init()]

        self.carouselItemProviders.forEach {
            $0.set(items: [
                UIImage(named: "img1")!,
                UIImage(named: "img2")!,
                UIImage(named: "img3")!,
                UIImage(named: "img4")!,
                UIImage(named: "img5")!,
            ])
        }

        self.carouselProvider.set(itemDataSources: self.carouselItemProviders)
        self.collectionView.delaysContentTouches = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
}
