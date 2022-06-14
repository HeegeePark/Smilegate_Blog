//
//  HomeViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/05.
//

import Foundation

class HomeViewModel {
    var postingList: [Posting] = [] {
        didSet {
            if !postingList.isEmpty {
                Posting.identifier = Int(sortedList.first!.identifier)! + 1
            }
        }
    }
    
    // timestamp 기준 내림차순 정렬
    var sortedList: [Posting] {
        let sortedList = postingList.sorted { prev, next in
            return prev.timestamp > next.timestamp
        }
        return sortedList
    }
    
    var numOfPostingList: Int {
        return postingList.count
    }
    
    func posting(at index: Int) -> Posting {
        return sortedList[index]
    }
}
