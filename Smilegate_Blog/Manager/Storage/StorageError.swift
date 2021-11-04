//
//  StorageError.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import Foundation

public enum StorageError: Error {
    case failedToUpload
    case failedToGetDownloadUrl
}
