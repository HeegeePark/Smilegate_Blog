//
//  CommentViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/09.
//

import UIKit

class CommentViewController: UIViewController {
    let viewModel = CommentViewModel()
    let user = User.shared
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint! // 키보드 올라갈 시 조정할 것
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var emptyCommentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        guard let presentVC = self.presentingViewController else { return }
        self.dismiss(animated: true) {
            presentVC.present(PostViewController(), animated: true, completion: nil)
        }
    }
    @IBAction func reloadButtonTapped(_ sender: Any) {
        fetchComments()
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        if tableView.isHidden == true { showTableView() }
        let contents = inputTextField.text ?? ""
        let timestamp: Double = Date().timeIntervalSince1970.rounded()
        let newComment = Comment(id: String(Comment.id), userName: user.name, content: contents, timestamp: timestamp)
        viewModel.updateComment(comment: newComment)
        Comment.id += 1
        fetchComments()
    }
    
    func updateUI() {
        if viewModel.isExist {
            showTableView()
            tableView.reloadData()
        } else {
            hideTableView()
        }
    }
    
    func fetchComments() {
        viewModel.manager.fetchComment(postingId: viewModel.postingId) { comments in
            self.viewModel.commentsList = comments
            if !self.viewModel.isExist {
                self.viewModel.isExist = true
            }
            self.updateUI()
        }
    }
    
    func hideTableView() {
        tableView.isHidden = true
        emptyCommentLabel.isHidden = false
    }
    
    func showTableView() {
        tableView.isHidden = false
        emptyCommentLabel.isHidden = true
    }
}

extension CommentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfCommentsList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        let commentInfo = viewModel.comment(at: indexPath.row)
        cell.updateUI(info: commentInfo)
        
        // deleteButtonHandler
        cell.deleteButtonTapHandler = {
            self.viewModel.deleteComment(comment: commentInfo)
            self.fetchComments()
        }
        return cell
    }
}
