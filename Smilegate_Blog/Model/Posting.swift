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
    let timestamp: TimeInterval
    var imageURL: String = ""
    var comments: [Comment]
    var likes: String
    
    var toDictionary: [String: Any] {
        let commentsArray = comments.map { $0.toDictionary }
        let dict: [String: Any] = ["identifier": identifier,
                                   "userName": userName,
                                   "title": title,
                                   "contents": contents,
                                   "timestamp": timestamp,
                                   "imageURL": imageURL,
                                   "comments": commentsArray,
                                   "likes": likes]
        return dict
    }
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case userName
        case title
        case contents
        case timestamp
        case imageURL
        case comments
        case likes
    }
    static var identifier: Int = 0
}
