//
//  UIViewController+.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/03.
//

import UIKit

extension UIViewController {
    func wrappendByNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.interactivePopGestureRecognizer?.delegate = nil
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
}
