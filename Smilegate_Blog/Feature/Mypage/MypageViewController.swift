//
//  MypageViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/03.
//

import UIKit

class MypageViewController: UIViewController {
    let viewModel = MypageViewModel()
    
    private lazy var headerView: MypageHeaderView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 307.5)
        let view = MypageHeaderView(frame: frame)
        view.delegate = self
        view.viewModel?.update(model: viewModel.user)
        return view
    }()
    
    @IBOutlet weak var postTableView: UITableView!
    
    // segue 수행되기 직전 준비하는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // PostViewController에 선택한 posting 넘기기
        if segue.identifier == "showPost" {
            let postViewController = segue.destination as? PostViewController
            if let index = sender as? Int {
                let postingInfo = viewModel.posting(at: index)
                postViewController?.viewModel.update(model: postingInfo, prev: .home)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        postTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "MypageHeaderView")
        fetchPosts()
    }
    
    func fetchPosts() {
        DatabaseManager.shared.fetchPosting { postings in
            self.viewModel.update(postings: postings)
            self.postTableView.refreshControl?.endRefreshing()
            self.postTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MypageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfMyPostingList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mypageCell", for: indexPath) as? MypageCell else {
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
    
// MARK: - UITableViewHeader
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 307.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MypageHeaderView")
        return headerView
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let header = view as? UITableViewHeaderFooterView else { return }
//        header.backgroundView = headerView
//
//    }
}

// MARK: - MypageHeaderViewDelegate
extension MypageViewController: MypageHeaderViewDelegate {
    func setUserInfo(_ headerView: MypageHeaderView, info: User) {
        print("~~~~~~~~~~>클릭됨")
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        settingVC.viewModel.update(model: info)
        settingVC.modalPresentationStyle = .fullScreen
        present(settingVC, animated: true, completion: nil)
    }
}
