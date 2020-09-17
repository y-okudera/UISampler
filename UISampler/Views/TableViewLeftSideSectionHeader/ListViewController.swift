//
//  ListViewController.swift
//  UISampler
//
//  Created by okudera on 2020/09/17.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController, LeftSideHeaderViewCompatible {

    var leftSideHeaderViews = [ListViewController.LeftSideHeaderViewData]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewLeadingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TableViewLeftSideSectionHeader"
        self.updateHeadersLocation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateHeadersLocation()
    }
}

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section)-\(indexPath.row)"
        return cell
    }
}

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ListViewController didSelectRowAt", indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateHeadersLocation()
    }
}
