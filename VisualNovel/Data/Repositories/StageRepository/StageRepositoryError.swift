//
//  StageRepositoryError.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

enum StageRepositoryError: Error {
    case failedLoadData, failedReceiptStage
    
    var description: String {
        switch self {
        case .failedLoadData:
            return "Failed load data"
        case .failedReceiptStage:
            return "Failed receipt stage"
//            добавить ошибки с чтением json и получением даты
        }
    }
}
