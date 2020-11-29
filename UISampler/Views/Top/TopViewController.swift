//
//  TopViewController.swift
//  UISampler
//
//  Created by okudera on 2020/09/09.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

enum UISample: Int, CaseIterable {
    case autoScroll
    case favoriteAnimation
    case tableViewLeftSideHeader
    case alertSlideInFromBottom
    case alertSlideInFromTop
    case alertSlideInFromRight
    case alertSlideInFromLeft
    case alertFadeIn
    case alertScaledUp
    case stepCollectionViewLayout

    var title: String {
        switch self {
        case .autoScroll:
            return "AutoScrollCarousel"
        case .favoriteAnimation:
            return "FavoriteAnimation"
        case .tableViewLeftSideHeader:
            return "TableViewLeftSideSectionHeader"
        case .alertSlideInFromBottom:
            return "Alert-SlideInFromBottom"
        case .alertSlideInFromTop:
            return "Alert-SlideInFromTop"
        case .alertSlideInFromRight:
            return "Alert-SlideInFromRight"
        case .alertSlideInFromLeft:
            return "Alert-SlideInFromLeft"
        case .alertFadeIn:
            return "Alert-FadeIn"
        case .alertScaledUp:
            return "Alert-ScaledUp"
        case .stepCollectionViewLayout:
            return "StepCollectionViewLayout"
        }
    }
}

final class TopViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tableView.indexPathsForSelectedRows?.forEach {
            self.tableView.deselectRow(at: $0, animated: true)
        }
    }
}

extension TopViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UISample.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let uiSample = UISample(rawValue: indexPath.row)!
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = uiSample.title
        return cell
    }
}

extension TopViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TopViewController didSelectRowAt", indexPath)
        let uiSample = UISample(rawValue: indexPath.row)!

        switch uiSample {
        case .autoScroll:
            let autoScrollVC: AutoScrollViewController = .instantiate()
            self.navigationController?.pushViewController(autoScrollVC, animated: true)
        case .favoriteAnimation:
            let tabBarController: TabBarController = .instantiate()
            self.navigationController?.pushViewController(tabBarController, animated: true)
        case .tableViewLeftSideHeader:
            let listVC: ListViewController = .instantiate()
            self.navigationController?.pushViewController(listVC, animated: true)
        case .alertSlideInFromBottom:
            let alertVC = RegisterAlertViewController.instance(transitionType: .slideInFromBottom)
            self.present(alertVC, animated: true)
        case .alertSlideInFromTop:
            let alertVC = RegisterAlertViewController.instance(transitionType: .slideInFromTop)
            self.present(alertVC, animated: true)
        case .alertSlideInFromRight:
            let alertVC = RegisterAlertViewController.instance(transitionType: .slideInFromRight)
            self.present(alertVC, animated: true)
        case .alertSlideInFromLeft:
            let alertVC = RegisterAlertViewController.instance(transitionType: .slideInFromLeft)
            self.present(alertVC, animated: true)
        case .alertFadeIn:
            let alertVC = RegisterAlertViewController.instance(transitionType: .fadeIn)
            self.present(alertVC, animated: true)
        case .alertScaledUp:
            let alertVC = RegisterAlertViewController.instance(transitionType: .scaledUp)
            self.present(alertVC, animated: true)
        case .stepCollectionViewLayout:
            let stepCollectionVC: StepCollectionViewViewController = .instantiate()
            self.navigationController?.pushViewController(stepCollectionVC, animated: true)
        }
    }
}
