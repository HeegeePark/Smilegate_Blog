//
//  CommentCell.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/09.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // delete button Handler
    var deleteButtonTapHandler: (() -> Void)?
    
    func updateUI(info: Comment) {
        nameLabel.text = info.userName
        commentLabel.text = info.content
    }
    @IBAction func deleteCommentButtonTapped(_ sender: Any) {
        // delete comment
        deleteButtonTapHandler?()
    }
}
