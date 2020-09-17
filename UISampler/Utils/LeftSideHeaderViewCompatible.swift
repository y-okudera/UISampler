//
//  LeftSideHeaderViewCompatible.swift
//  UISampler
//
//  Created by okudera on 2020/09/17.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

struct LeftSideHeaderViewData {
    let section: Int
    let headerView: UIView
}

protocol LeftSideHeaderViewCompatible: AnyObject {
    var leftSideHeaderViews: [LeftSideHeaderViewData] { get set }
    var tableView: UITableView! { get }
    var tableViewLeadingConstraint: NSLayoutConstraint! { get }

    /// ヘッダビューの位置を更新する
    func updateHeadersLocation()
}

extension LeftSideHeaderViewCompatible where Self: UIViewController {

    func updateHeadersLocation() {

        // tableViewの左側の制約にヘッダビューの幅を設定
        tableViewLeadingConstraint.constant = self.defaultHeaderViewFrame().width

        let sectionCount = tableView.numberOfSections

        for section in 0..<sectionCount {

            // 対象セクションのRect（画面を基準とした座標系）
            let sectionsConvertedRect = tableView.convert(tableView.rect(forSection: section), to: tableView.superview)
            // 重なっている部分のRect
            let intersection = sectionsConvertedRect.intersection(tableView.frame)

            var headerViewFrame = self.defaultHeaderViewFrame()

            if sectionsConvertedRect.origin.y >= tableView.frame.origin.y {
                // 対象セクションのトップがtableViewのトップより下にある場合
                // （対象セクションの一番上が表示されている場合）
                // 連動して動かす
                headerViewFrame.origin.y = sectionsConvertedRect.origin.y
            }
            else if intersection.size.height >= headerViewFrame.size.height {
                // 対象セクションのトップがtableViewのトップより上にあって、ヘッダビューの高さより対象セクションの高さが大きい場合
                // （対象セクションの一部が表示されている場合）
                // ヘッダビューを上部に固定
                headerViewFrame.origin.y = tableView.frame.origin.y
            }
            else {
                // 対象セクションの表示されている高さががヘッダビューの高さより小さい場合
                // ヘッダビューを上に移動させる
                headerViewFrame.origin.y = tableView.frame.origin.y + intersection.size.height - headerViewFrame.size.height
            }

            var headerView = self.leftSideHeaderViews
                .filter { $0.section == section }
                .first?
                .headerView

            defer {
                headerView?.frame = headerViewFrame
            }

            // 対象セクションがTableViewのframeと重なっていない場合は、Arrayから削除する
            if intersection.size.height == 0, let headerView = headerView {
                self.removeHeaderView(headerView, for: section)
                continue
            }

            // 対象セクションがTableViewのframeと重なっている場合は、Arrayに追加する
            if intersection.size.height > 0, headerView == nil {
                headerView = self.headerViewForSection(section)
                self.addHeaderView(headerView!, for: section)
            }
        }
    }

    /// ヘッダビューのデフォルトのframe
    private func defaultHeaderViewFrame() -> CGRect {
        return .init(x: 0, y: 0, width: 60, height: 60)
    }

    /// ヘッダビューを生成する
    private func headerViewForSection(_ section: Int) -> UIView {

        let image = UIImage(named: "square-img\(section + 1)")!
        let headerView = LeftSideHeaderView(frame: self.defaultHeaderViewFrame())
        headerView.configure(image: image)
        return headerView
    }

    /// ヘッダビューをリストに追加する
    private func addHeaderView(_ headerView: UIView, for section: Int) {

        self.leftSideHeaderViews.append(.init(section: section, headerView: headerView))
        self.view.addSubview(headerView)
    }

    /// ヘッダビューをリストから削除する
    private func removeHeaderView(_ headerView: UIView, for section: Int) {

        headerView.removeFromSuperview()
        if let index = self.leftSideHeaderViews.firstIndex(where: { $0.section == section }) {
            self.leftSideHeaderViews.remove(at: index)
        }
    }
}
