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
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var postLine: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        fetchComments()
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
        viewModel.manager.fetchComment(postingId: viewModel.posting!.identifier) { comments in
            self.viewModel.commentsList = comments
            self.viewModel.commentsCount = comments.count
        }
        commentsNumLabel.text = String(viewModel.commentsCount)
    }
    
    func initUI() {
        hideComponents()
    }
    
    func updateUI() {
        if let postInfo = viewModel.posting {
            showComponents()
            guard postInfo.imageURL != "" else {
                imgView.image = UIImage(named: "img_default")
                titleLabel.text = postInfo.title
                nameLabel.text = postInfo.userName
                contentLabel.text = postInfo.contents
                likesNumLabel.text = postInfo.likes
                commentsNumLabel.text = String(viewModel.commentsCount)
                return
            }
            imgView.image = manager.downloadImage(urlString: postInfo.imageURL)
            titleLabel.text = postInfo.title
            nameLabel.text = postInfo.userName
            contentLabel.text = postInfo.contents
            likesNumLabel.text = postInfo.likes
            commentsNumLabel.text = String(viewModel.commentsCount)
        }
    }
    
    func hideComponents() {
        imgView.isHidden = true
        titleLabel.isHidden = true
        nameLabel.isHidden = true
        contentLabel.isHidden = true
        titleLabel.isHidden = true
        userImageView.isHidden = true
        postLine.isHidden = true
    }
    
    func showComponents() {
        imgView.isHidden = false
        titleLabel.isHidden = false
        nameLabel.isHidden = false
        contentLabel.isHidden = false
        titleLabel.isHidden = false
        userImageView.isHidden = false
        postLine.isHidden = false
    }
    
    func fetchComments() {
        viewModel.manager.fetchComment(postingId: viewModel.posting!.identifier) { comments in
            self.viewModel.commentsList = comments
            if self.viewModel.hasComments() {
                self.viewModel.commentsCount = comments.count
            }
            self.updateUI()
        }
    }
}
