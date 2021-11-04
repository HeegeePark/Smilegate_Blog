//
//  StorageManager.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    public typealias UploadImageCompletion = (Result<String, Error>) -> Void
}

// MARK: - Upload Image
extension StorageManager {
    public func uploadImage(img: UIImage, identifier: String, path: String, completion: @escaping UploadImageCompletion) {
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = "\(path)/\(identifier)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.child(filePath).putData(data, metadata: metaData, completion: { [weak self] metadata, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                // failed
                print("image 업로드 실패")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            strongSelf.storage.child(filePath).downloadURL { url, error in
                guard let url = url else {
                    print("image url 다운로드 실패")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            }
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
}

