//
//  WelcomeViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class WelcomeViewModel {
    typealias Factory = StageRepositoryFactory
    
    var didUpdateHeader: ((String?) -> Void)?
    var didUpdateTitle: ((String?) -> Void)?
    var didUpdateName: ((String) -> Void)?
    var didGoToGameScreen: ((Int) -> Void)?
    
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

extension WelcomeViewModel: WelcomeViewModelType {
    func getStageDetail() {
        loadStage()
    }
    
    func startGame(with userName: String?) {
        guard let userName = userName else { return }
        guard let stageId = stage?.options[0].id else { return }
        
        stageRepository.updateWelcomeStage(with: stageId, userName: userName)
        didGoToGameScreen?(stageId)
    }
    
    func checkLengthValid(_ name: String?) {
        guard var name = name else { return }
        guard name.count > 40 else { return }
        
        name.removeLast()
        didUpdateName?(name)
    }
}

private extension WelcomeViewModel {
    func updateDetail() {
        didUpdateHeader?(stage?.header)
        didUpdateTitle?(stage?.options[0].title)
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
