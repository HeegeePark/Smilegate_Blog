//
//  UserViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/12.
//

import Foundation

class UserViewModel {
    var user: User? = nil
    
    var name: String { return user!.name }
    var title: String { return user!.blogTitle }
    var introduce: String { return user!.introduce }
    
    func update(model: User?) {
        guard let userInfo = model, user != nil else { return }
        user = userInfo
    }
}
