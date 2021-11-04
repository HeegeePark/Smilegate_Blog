//
//  MainTabBarController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/03.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barStyle = .default
        self.tabBar.barTintColor = .baseColor
        self.tabBar.backgroundColor = .white
    }
}
