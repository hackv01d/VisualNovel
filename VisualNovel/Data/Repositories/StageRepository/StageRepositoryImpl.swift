//
//  StageRepositoryImpl.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class StageRepositoryImpl: StageRepository {
    
    private var stages: [StageDTO] = []
    
    init() {
        loadStages()
    }
    
    private func getJsonFilePath(jsonFileName: String) -> String? {
        return Bundle.main.path(forResource: jsonFileName, ofType: "json")
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
    
    func getStage(for stageId: Int, completion: (Result<Stage, StageRepositoryError>) -> Void) {
        if let stage = stages.first(where: { $0.id == stageId })?.toStage() {
            completion(.success(stage))
        } else {
            completion(.failure(StageRepositoryError.failedReceiptStage))
        }
    }
}
