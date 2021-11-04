//
//  DatabaseManager.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    // Firebase Realtime Database
    private let database = Database.database().reference()
}

// MARK: - User Management
extension DatabaseManager {
    public func updateUser(user: User) {
        database.child("user").child(user.id).setValue(user.toDictionary)
    }
}

// MARK: - Posting Management
extension DatabaseManager {
    public func fetchPosting(completion: @escaping ([Posting]) -> Void) {
        database.child("posting").observeSingleEvent(of: .value) { snapshot in
            print("----> \(snapshot.value)")
            do {
                // JSON Decoding
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                let decoder = JSONDecoder()
                let postings: [Posting] = try decoder.decode([Posting].self, from: data)
                completion(postings)
            } catch let error {
                print("--> error: \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    public func updatePosting(_ user: User, _ posting: Posting) {
        // posting db에 업뎃
        database.child("posting").child(posting.identifier).setValue(posting.toDictionary)
    }
    
    /// delete posting
    public func deletePosting(identifier: String) {
        // 해당 유저의 postingArray에 삭제하고 다시 갱신
        database.child("posting").child(identifier).removeValue()
    }
    
}

// MARK: - Comment Management
extension DatabaseManager {
    func fetchComment(postingId: Int, completion: @escaping ([Comment]) -> Void) {
        database.child("posting").child(String(postingId)).child("comments").observeSingleEvent(of: .value) { snapshot in
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                let decoder = JSONDecoder()
                let comments: [Comment] = try decoder.decode([Comment].self, from: data)
                completion(comments)
            } catch let error {
                print("--> error: \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    func updateComment(postingId: Int, comment: Comment) {
        let dbPath = "posting/\(String(postingId))/comments/\(String(comment.id))"
        database.child(dbPath).setValue(comment.toDictionary)
    }
    
    func deleteComment(postingId: Int, id: Int) {
        let dbPath = "posting/\(String(postingId))/comments/\(String(id))"
        database.child(dbPath).removeValue()
    }
}
