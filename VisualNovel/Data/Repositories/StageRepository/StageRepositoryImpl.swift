//
//  StageRepositoryImpl.swift
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
        }
    }
}

final class StageRepositoryImpl {
    
    private var stages: [StageDTO] = []
    
    init() {
        loadStages()
    }
    
    private func loadStages() {
        guard let path = getJsonFilePath(jsonFileName: "stages") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let result = try JSONDecoder().decode(StageResponse.self, from: data)
            stages = result.stages
        } catch {
            print(StageRepositoryError.failedLoadData)
        }
    }
    
    private func getJsonFilePath(jsonFileName: String) -> String? {
        return Bundle.main.path(forResource: jsonFileName, ofType: "json")
    }
}

extension StageRepositoryImpl: StageRepository {
    func getStage(for stageId: Int, completion: (Result<Stage, StageRepositoryError>) -> Void) {
        if let stage = stages.first(where: { $0.id == stageId })?.toStage() {
            completion(.success(stage))
        } else {
            completion(.failure(StageRepositoryError.failedReceiptStage))
        }
    }
}
