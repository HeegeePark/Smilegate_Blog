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
        
        // 키보드 상태 디텍션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        guard let contents = inputTextField.text, contents.isEmpty == false else { return }
        let timestamp: Double = Date().timeIntervalSince1970.rounded()
        let newComment = Comment(id: String(Comment.id), userName: user.name, content: contents, timestamp: timestamp)
        viewModel.updateComment(comment: newComment)
        Comment.id += 1
        fetchComments()
    }
    @IBAction func tapBG(_ sender: Any) {
        // 화면 어디든 탭하면 키보드 사라지게 하기
        inputTextField.resignFirstResponder()
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
            self.inputTextField.text = ""
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

// MARK: - 키보드 높이에 따른 텍스트 입력창 위치 변경
extension CommentViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            inputViewBottom.constant = adjustmentHeight
        } else {
            inputViewBottom.constant = 0
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
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
