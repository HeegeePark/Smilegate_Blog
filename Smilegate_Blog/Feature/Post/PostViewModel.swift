//
//  PostViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/05.
//

import Foundation

class PostViewModel {
    let manager = DatabaseManager.shared
    var posting: Posting?
    var editMode: EditMode = .modify
    var commentsList: [Comment] = []
    var commentsCount = 0
    // 모델 불러오기
    func update(model: Posting?) {
        posting = model
    }
    
    func updateLikes(_ didLikes: Bool) {
        if didLikes {
            addLikes()
        } else {
            cancelLikes()
        }
    }
    
    func addLikes() {
        let count = Int(posting!.likes)! + 1
        posting!.likes = String(count)
        manager.updatePosting(posting!)
    }
    
    func cancelLikes() {
        let count = Int(posting!.likes)! - 1
        posting!.likes = String(count)
        manager.updatePosting(posting!)
    }
    
    func hasComments() -> Bool {
        let isExist = commentsList.first?.id != "" ? true: false
        return isExist
    }
}
