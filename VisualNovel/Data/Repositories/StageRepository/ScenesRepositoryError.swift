//
//  ScenesRepositoryError.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

enum ScenesRepositoryError: Error {
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
