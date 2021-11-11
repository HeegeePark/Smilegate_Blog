//
//  PostViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/05.
//

import Foundation

class PostViewModel {
    let manager = DatabaseManager.shared
    var posting: Posting? {
        didSet { if posting != nil && from == .edit { postHandler?() }}
    }
    var editMode: EditMode = .modify
    var commentsList: [Comment] = []
    var commentsCount = 0
    var postHandler: (() -> Void)?
    var from: PreviousVC = .edit
    
    // 모델 불러오기
    func update(model: Posting?, prev: PreviousVC) {
        posting = model
        from = prev
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
}

public enum PreviousVC {
    case home
    case edit
}
