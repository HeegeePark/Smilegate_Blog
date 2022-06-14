//
//  MypageViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/11.
//

import Foundation

class MypageViewModel {
    var myPostingList: [Posting] = []
    var user = User.shared
    
    var sortedList: [Posting] {
        let sortedList = myPostingList.sorted { prev, next in
            return prev.timestamp > next.timestamp
        }
        return sortedList
    }
    
    var numOfMyPostingList: Int {
        return myPostingList.count
    }
    
    func update(postings: [Posting]) {
        myPostingList = postings.filter { posting in
            return posting.userName == User.shared.name
        }
    }
    
    func posting(at index: Int) -> Posting {
        return sortedList[index]
    }
}
