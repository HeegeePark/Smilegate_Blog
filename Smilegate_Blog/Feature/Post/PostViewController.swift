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
    let user = User.shared
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var manageButton: UIButton!
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // comments 넘기기
        if segue.identifier == "showComment" {
            let commentViewController = segue.destination as? CommentViewController
            if let postingInfo = sender as? Posting {
                commentViewController?.viewModel.update(model: viewModel.commentsList, posting: postingInfo)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
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
        performSegue(withIdentifier: "showComment", sender: viewModel.posting!)
    }
    
    func initUI() {
        if user.name != viewModel.posting?.userName { hideManageButton() }
        hideComponents()
        loadPosting()
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
    
    func hideManageButton() {
        manageButton.isHidden = true
    }
    
    func loadPosting() {
        switch viewModel.from {
        case .edit:
                viewModel.postHandler = {
                    self.updateUI()
                }
        case .home:
            self.updateUI()
        }
    }
}

// MARK: - manage Post Actions
extension PostViewController {
    @IBAction func manageButtonTapped(_ sender: Any) {
        let managePostPicker = UIAlertController()
        let editPost = UIAlertAction(title: "글 수정하기", style: .default) { [unowned self] _ in
            self.editPost()
        }
        let deletePost = UIAlertAction(title: "글 삭제하기", style: .default) { [unowned self] _ in
            self.deletePost()
        }
        
        managePostPicker.addAction(editPost)
        managePostPicker.addAction(deletePost)
        managePostPicker.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(managePostPicker, animated: true)
    }
    
    func editPost() {
        // write컨뷰로 postingInfo 넘겨서 띄우기
        guard let presentVC = self.presentingViewController else { return }
        let storyBoard = UIStoryboard(name: "Write", bundle: nil)
        let writeVC = storyBoard.instantiateViewController(withIdentifier: "WriteViewController") as! WriteViewController
        guard let editVC = writeVC.viewControllers.first as? EditViewController else { return }
        
        editVC.viewModel.update(model: viewModel.posting)
        editVC.viewModel.editMode = .modify
        writeVC.modalPresentationStyle = .fullScreen
        
        self.dismiss(animated: false) {
            presentVC.present(writeVC, animated: true, completion: nil)
        }
    }
    
    func deletePost() {
        let alert = UIAlertController(title: nil, message: "삭제된 글은 복구가 불가능합니다. 글을 삭제하시겠습니까?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "확인", style: .destructive) { [unowned self] _ in
            self.viewModel.deletePosting()
            
            guard let presentVC = self.presentingViewController else { return }
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainTBC = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            
            mainTBC.modalPresentationStyle = .fullScreen
            self.dismiss(animated: false) {
                presentVC.present(mainTBC, animated: true, completion: nil)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
