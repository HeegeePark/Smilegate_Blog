//
//  UIStoryboard+.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import UIKit

extension UIStoryboard {
    func instantiate(_ identifier: String) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier)
    }
}
