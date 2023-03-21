//
//  GameViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 20.03.2023.
//

import Foundation

final class GameViewModel {
    typealias Factory = StageRepositoryFactory
    
    var didUpdateHeader: ((String?) -> Void)?
    var didUpdateTitle: ((String?) -> Void)?
    
    private let factory: Factory
    private lazy var stageRepository = factory.makeStageRepository()
    
    private let stageId: Int
    private var stage: Stage? {
        didSet {
            updateDetail()
        }
    }
    
    init(factory: Factory, stageId: Int) {
        self.factory = factory
        self.stageId = stageId
    }
}

extension GameViewModel: GameViewModelType {
    func getStageDetail() {
        loadStage()
    }
}

private extension GameViewModel {
    func updateDetail() {
        guard let header = stage?.header else { return }
        print(header)
//        header = header.replacingOccurrences(of: "<>", with: userName ?? "")
//        didUpdateHeader?(header)
//        didUpdateTitle?()
    }
    
    func loadStage() {
        stageRepository.getStage(for: stageId) { result in
            switch result {
            case .success(let stage):
                self.stage = stage
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
}
