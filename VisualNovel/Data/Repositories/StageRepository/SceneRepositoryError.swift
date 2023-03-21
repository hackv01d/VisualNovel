//
//  SceneRepositoryError.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

enum SceneRepositoryError: Error {
    case failedLoadData, failedReceiptScene
    
    var description: String {
        switch self {
        case .failedLoadData:
            return "Failed load data"
        case .failedReceiptScene:
            return "Failed receipt scene"
        }
    }
}
