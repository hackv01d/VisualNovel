//
//  ScenesRepositoryError.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

enum ScenesRepositoryError: Error {
    case failedToGetFilePath
    case failedToGetData
    case failedToParseData
    case failedToReceiveScene
    
    var description: String {
        switch self {
        case .failedToGetFilePath:
            return LocalizedStrings.failedToGetFilePath()
        case .failedToGetData:
            return LocalizedStrings.failedToGetData()
        case .failedToParseData:
            return LocalizedStrings.failedToParseData()
        case .failedToReceiveScene:
            return LocalizedStrings.failedToReceiveScene()
        }
    }
}
