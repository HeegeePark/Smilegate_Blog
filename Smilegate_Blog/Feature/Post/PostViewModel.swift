//
//  PostViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/05.
//

import Foundation

class PostViewModel {
    var posting: Posting?
    var editMode: EditMode = .create
    // 모델 불러오기
    func update(model: Posting?) {
        posting = model
    }
}
