//
//  StageRepositoryImpl.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class StageRepositoryImpl {
    
    private var stages: [Stage] = []
    
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
            stages = result.stages.map { $0.toStage() }
        } catch {
            print(StageRepositoryError.failedLoadData)
        }
    }
}

extension StageRepositoryImpl: StageRepository {
    func getStage(for stageId: Int, completion: (Result<Stage, StageRepositoryError>) -> Void) {
        if let stage = stages.first(where: { $0.id == stageId }) {
            completion(.success(stage))
        } else {
            completion(.failure(StageRepositoryError.failedReceiptStage))
        }
    }
    
    func updateWelcomeStage(with stageId: Int, userName: String?) {
        guard let indexStage = stages.firstIndex(where: { $0.id == stageId }) else { return }
        guard let newUserName = userName?.replacingOccurrences(of: "((^\\s+)|(\\s+$))",
                                                               with: "",
                                                               options: .regularExpression) else { return }
        
        var stage = stages[indexStage]
        stage.header = stage.header.replacingOccurrences(of: stage.userName ?? "unknown", with: newUserName)
        stage.userName = newUserName
        stages[indexStage] = stage
    }
}
