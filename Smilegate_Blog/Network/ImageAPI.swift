//
//  ImageAPI.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import Foundation
import FirebaseStorage

final class ImageAPI {
    static let shared = ImageAPI()
    private let storage = Storage.storage()
}

// MARK: - Upload Image
extension ImageAPI {
    public func uploadImage(img: UIImage, identifier: String, path: String) {
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = "\(path)/\(identifier)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data, metadata: metaData) { (metaData, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("---- \(path) 성공 ----")
            }
        }
    }
}
