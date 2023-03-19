//
//  StartViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class StartViewModel {
    
    var didUpdateHeader: ((String?) -> Void)?
    var didUpdateTitle: ((String?) -> Void)?
    var didGoToNextScreen: ((Int) -> Void)?
    
    typealias Factory = StageRepositoryFactory
    
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

extension StartViewModel: StartViewModelType {
    func getStageDetail() {
        loadStage()
    }
    
    func moveOn() {
        guard let stageId = stage?.options[0].id else { return }
        didGoToNextScreen?(stageId)
    }
}

private extension StartViewModel {
    func updateDetail() {
        didUpdateHeader?(stage?.header)
        didUpdateTitle?(stage?.options[0].title)
    }
    
    func loadStage() {
        stageRepository.getStage(for: stageId) { [weak self] result in
            switch result {
            case .success(let stage):
                self?.stage = stage
            case .failure(let error):
                print(error.description)
            }
        }
    }
}
