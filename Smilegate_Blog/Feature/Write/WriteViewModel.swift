//
//  WriteViewModel.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/05.
//

import Foundation
import UIKit

class WriteViewModel {
    var posting: Posting?
    var editMode: EditMode = .create
    var beReadyImageHandler: (() -> Void)?
    // 모델 불러오기
    func update(model: Posting?) {
        posting = model
    }
    // 게시글 올리기
    func updatePosting() {
        let user = User.shared
        let dbManager = DatabaseManager.shared
        dbManager.updatePosting(posting!)
//        Posting.identifier += 1
    }
    func updateImage(image: UIImage) {
        let manager = StorageManager.shared
        manager.uploadImage(img: image, identifier: "\(Posting.identifier)", path: "Posting") { result in
            switch result {
            case .success(let downloadUrl):
                self.posting!.imageURL = downloadUrl
                self.updatePosting()
                self.beReadyImageHandler?()
            case .failure(let error):
                print("storage manager error: \(error)")
            }
        }
    }
}

public enum EditMode {
    case create // 새 글 작성 시
    case modify // 기존 글 수정 시
}
