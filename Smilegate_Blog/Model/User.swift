//
//  User.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import Foundation
import UIKit

struct User: Codable {
    let id: String
    var name: String
    var blogTitle: String
    var urlString: String = ""
    var mainImageUrl: URL
    var profile: String
    var postings: [Posting]
    
    var toDictionary: [String: Any] {
        let postingsArray = postings.map { $0.toDictionary }
        let dict: [String: Any] = ["id": id,
                                   "name": name,
                                   "blogTitle": blogTitle,
                                   "mainImage": urlString,
                                   "profile": profile,
                                   "postings": postingsArray]
        return dict
    }
    static var id: Int = 0
}
