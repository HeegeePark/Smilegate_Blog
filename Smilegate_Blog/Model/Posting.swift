//
//  Posting.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import Foundation
import UIKit

struct Posting: Codable {
    var identifier: String
    var userName: String
    var title: String
    var contents: String
    var urlString: String = ""
    var image: URL?
    var comments: [Comment]
    var likes: Int
    
    var toDictionary: [String: Any] {
        let commentsArray = comments.map { $0.toDictionary }
        let dict: [String: Any] = ["identifier": identifier,
                                   "userName": userName,
                                   "title": title,
                                   "contents": contents,
                                   "image": urlString,
                                   "comments": commentsArray,
                                   "likes": String(likes)]
        return dict
    }
    static var identifier: Int = 0
}
