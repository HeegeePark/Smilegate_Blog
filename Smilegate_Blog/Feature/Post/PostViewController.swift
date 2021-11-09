//
//  PostViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/03.
//

import UIKit

class PostViewController: UIViewController {
    let viewModel = PostViewModel()
    let manager = StorageManager.shared
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var likesNumLabel: UILabel!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var commentsNumLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainTBC = sb.instantiate("MainTabBarController")
        mainTBC.modalPresentationStyle = .fullScreen
        present(mainTBC, animated: true, completion: nil)
    }
    
    @IBAction func likesButtonTapped(_ sender: Any) {
        likesButton.isSelected = !likesButton.isSelected
        viewModel.updateLikes(likesButton.isSelected)
        likesNumLabel.text = viewModel.posting?.likes
        
    }
    
    @IBAction func commentsButtonTapped(_ sender: Any) {
        
    }
    
    func updateUI() {
        if let postInfo = viewModel.posting {
            guard postInfo.imageURL != "" else {
                imgView.image = UIImage(named: "img_default")
                titleLabel.text = postInfo.title
                nameLabel.text = postInfo.userName
                contentLabel.text = postInfo.contents
                likesNumLabel.text = postInfo.likes
//                commentsNumLabel.text = postInfo.comments.count
                return
            }
            imgView.image = manager.downloadImage(urlString: postInfo.imageURL)
            titleLabel.text = postInfo.title
            nameLabel.text = postInfo.userName
            contentLabel.text = postInfo.contents
            likesNumLabel.text = postInfo.likes
        }
    }
}
