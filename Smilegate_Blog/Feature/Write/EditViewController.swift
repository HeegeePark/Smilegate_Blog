//
//  EditViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import UIKit

class EditViewController: UIViewController {
@IBOutlet weak var uploadButton: UIBarButtonItem!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentsField: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func uploadButtonTapped(_ sender: Any) {
    }
    @IBAction func cameraButtonTapped(_ sender: Any) {
    }
    @IBAction func editingTitleStarted(_ sender: Any) {
        self.titleField.textColor = .textBlackColor
    }
    @IBAction func editingContentseStarted(_ sender: Any) {
        self.contentsField.textColor = .textBlackColor
    }
}
