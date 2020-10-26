//
//  AlertViewCompatible.swift
//  UISampler
//
//  Created by okudera on 2020/10/26.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

protocol AlertViewCompatible where Self: UIViewController {
    var transitionType: AlertTransitionType { get }
}
