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
    private let database = Database.database().reference()
}

// MARK: - User Management
extension DatabaseManager {
    /// Read(Fetch) Data
    public func fetchUsers() {
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            print("----> \(snapshot.value)")
            do {
                // JSON 만들기
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                let decoder = JSONDecoder()
                let users: [User] = try decoder.decode([User].self, from: datax)
            } catch let error {
                print("--> error: \(error.localizedDescription)")
            }
        }
    }
}
