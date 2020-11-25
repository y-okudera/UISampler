//
//  StepCollectionViewViewController.swift
//  UISampler
//
//  Created by okudera on 2020/09/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class StepCollectionViewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        willSet {
            newValue.register(cellType: PhotoCollectionViewCell.self)
        }
    }
    private let dataProvider = StepCollectionViewProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "StepCollectionViewLayout"
        self.setupCollectionView()
    }

    private func setupCollectionView() {
        var photos = [Photo]()
        for _ in 0..<100 {
            let randomIndex = Int.random(in: 0..<5)
            photos.append(Self.dummyPhotos[randomIndex])
        }
        self.dataProvider.add(photos: photos)
        self.collectionView.dataSource = dataProvider

        let flowLayout = StepCollectionViewLayout()
        flowLayout.delegate = dataProvider
        self.collectionView.collectionViewLayout = flowLayout
    }
}

extension StepCollectionViewViewController {

    static var dummyPhotos: [Photo] {
        let photo1 = Photo(
            caption: "レッサーパンダ",
            comment: "レッサーパンダの基本情報. IUCN Red List Range Mapより 生息地. ブータン・中国・ミャンマー・インド・ネパールの標高1,500～4,000mの森林に生息しています。",
            image: UIImage(named: "square-img1")
        )
        let photo2 = Photo(
            caption: "イヌ",
            comment: "イヌは、ネコ目- イヌ科- イヌ属に分類される哺乳類の一種である。",
            image: UIImage(named: "square-img3")
        )
        let photo3 = Photo(
            caption: "アザラシ",
            comment: "アザラシ（海豹、Phocidae）は、鰭脚類に含まれる海棲哺乳類のグループである。アザラシ科、もしくはアザラシ科アザラシ亜科に分類される。 北海道ではアイヌ語より「トッカリ」とも呼ばれている。",
            image: UIImage(named: "square-img2")
        )
        let photo4 = Photo(
            caption: "キリン",
            comment: "キリン は、哺乳綱偶蹄目キリン科キリン属に分類される偶蹄類。",
            image: UIImage(named: "square-img4")
        )
        let photo5 = Photo(
            caption: "ジャイアントパンダ",
            comment: "ジャイアントパンダ は、哺乳綱食肉目クマ科ジャイアントパンダ属に分類される食肉類。別名オオパンダ。",
            image: UIImage(named: "square-img5")
        )
        return [photo1, photo2, photo3, photo4, photo5]
    }
}
