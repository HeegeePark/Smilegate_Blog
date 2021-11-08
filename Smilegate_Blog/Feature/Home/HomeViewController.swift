//
//  HomeViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/03.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var postTableView: UITableView!
    let viewModel = HomeViewModel()
    
    // segue 수행되기 직전 준비하는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // PostViewController에 선택한 posting 넘기기
        if segue.identifier == "showPost" {
            let postViewController = segue.destination as? PostViewController
            if let index = sender as? Int {
                let postingInfo = viewModel.posting(at: index)
                postViewController?.viewModel.update(model: postingInfo)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        // 게시물 뷰모델에 불러오기
//        viewModel.update()
//        postTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        
    }
    
    func fetchPosts() {
        DatabaseManager.shared.fetchPosting { postings in
            self.viewModel.postingList = postings
            self.postTableView.refreshControl?.endRefreshing()
            self.postTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfPostingList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        let postingInfo = viewModel.posting(at: indexPath.row)
        cell.updateUI(info: postingInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPost", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 183
    }
}
