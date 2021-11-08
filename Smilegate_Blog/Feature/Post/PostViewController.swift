//
//  PostViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/03.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    let viewModel = PostViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainTBC = sb.instantiate("MainTabBarController")
        mainTBC.modalPresentationStyle = .fullScreen
        present(mainTBC, animated: true, completion: nil)
    }
}
