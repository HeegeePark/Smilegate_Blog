//
//  CommentViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/09.
//

import Foundation

class CommentViewModel {
    let manager = DatabaseManager.shared
    var commentsList: [Comment] = [] {
        didSet {
            if commentsList.count == 1 { isExist = false }
        }
    }
    var postingInfo: Posting?
    var postingId = ""
    var isExist: Bool = false
    
    // timestamp 기준 오름차순 정렬
    var sortedList: [Comment] {
        if !isExist { return [] }
        let sortedList = commentsList[1...commentsList.count-1].sorted { prev, next in
            return prev.timestamp < next.timestamp
        }
        return sortedList
    }
    
    var numOfCommentsList: Int {
        return sortedList.count
    }
    
    func update(model: [Comment], posting: Posting) {
        isExist = model.count != 1 ? true: false
        commentsList = model
        postingInfo = posting
        postingId = posting.identifier
        Comment.id = Int(commentsList.last!.id)! + 1
    }
    
    func comment(at index: Int) -> Comment {
        return sortedList[index]
    }
    
    func updateComment(comment: Comment) {
        commentsList += [comment]
        manager.updateComment(postingId: postingId, comment: comment)
    }
    
    func deleteComment(comment: Comment) {
        commentsList = commentsList.filter { presentComment in
            return presentComment.id != comment.id
        }
        manager.updateComments(postingId: postingId, comments: commentsList)
    }
}
