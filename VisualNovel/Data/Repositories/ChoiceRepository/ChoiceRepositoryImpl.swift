//
//  ChoiceRepositoryImpl.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class ChoiceRepositoryImpl {
    enum ChoiceRepositoryError: Error {
        case failedLoadData, failedReceiptChoice
        
        var errorDescription: String {
            switch self {
            case .failedLoadData:
                return "Failed load data"
            case .failedReceiptChoice:
                return "Failed receipt choice"
            }
        }
    }
    
    private var choices: [ChoiceDTO] = []
    
    init() {
        loadChoices()
    }
    
    private func loadChoices() {
        guard let path = getJsonFilePath(jsonFileName: "choices") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let result = try JSONDecoder().decode(ChoiceResponse.self, from: data)
            choices = result.choices
        } catch {
            print(ChoiceRepositoryError.failedLoadData)
        }
    }
    
    private func getJsonFilePath(jsonFileName: String) -> String? {
        return Bundle.main.path(forResource: jsonFileName, ofType: "json")
    }
}

extension ChoiceRepositoryImpl: ChoiceRepository {
    func getChoice(for choiceId: Int, completion: (Result<Choice, Error>) -> Void) {
        if let choice = choices.first(where: { $0.id == choiceId })?.toChoice() {
            completion(.success(choice))
        } else {
            completion(.failure(ChoiceRepositoryError.failedReceiptChoice))
        }
    }
}
