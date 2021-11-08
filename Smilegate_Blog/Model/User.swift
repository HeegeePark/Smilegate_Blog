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
    var profileURL: String = ""
    var mainImageURL: String = ""
    var introduce: String
    var postings: [Posting]
    
    var toDictionary: [String: Any] {
        let postingsArray = postings.map { $0.toDictionary }
        let dict: [String: Any] = ["id": id,
                                   "name": name,
                                   "blogTitle": blogTitle,
                                   "profileURL": profileURL,
                                   "mainImageURL": mainImageURL,
                                   "introduce": introduce]
        return dict
    }
    static var id: Int = 1
    static var shared = User(id: "0", name: "heegee park", blogTitle: "Hello iOS", introduce: "과수원 주인이 될래요🌝", postings: [])
}
