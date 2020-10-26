//
//  RegisterAlertViewController.swift
//  UISampler
//
//  Created by okudera on 2020/10/24.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class RegisterAlertViewController: UIViewController, AlertViewCompatible {

    var transitionType: AlertTransitionType = .fadeIn

    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension RegisterAlertViewController {

    class func instance(transitionType: AlertTransitionType) -> RegisterAlertViewController {
        let alertVC: RegisterAlertViewController = .instantiate()
        alertVC.modalPresentationStyle = .custom
        alertVC.transitioningDelegate = alertVC
        alertVC.transitionType = transitionType
        return alertVC
    }
}

extension RegisterAlertViewController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return AlertPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertTransition(willShow: true, transitionType: self.transitionType)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertTransition(willShow: false, transitionType: self.transitionType)
    }
}
