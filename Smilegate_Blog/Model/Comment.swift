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
        let dict: [String: Any] = ["id": id,
                                   "content": content,
                                   "timestamp": timestamp]
        return dict
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case timestamp
    }
    static var id: Int = 0
}
