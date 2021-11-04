//
//  Comment.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import Foundation

struct Comment: Codable {
    let id: String
    var content: String
    let timestamp: TimeInterval
    
    var toDictionary: [String: Any] {
        let dict: [String: Any] = ["id": id, "content": content]
        return dict
    }
}
