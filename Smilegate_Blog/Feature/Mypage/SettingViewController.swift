//
//  SettingViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/12.
//

import UIKit

class SettingViewController: UIViewController {
    var viewModel = UserViewModel()
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var introduceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
