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

    var title: String {
        switch self {
        case .autoScroll:
            return "AutoScrollCarousel"
        case .favoriteAnimation:
            return "FavoriteAnimation"
        case .tableViewLeftSideHeader:
            return "TableViewLeftSideSectionHeader"
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
        }
    }
}
