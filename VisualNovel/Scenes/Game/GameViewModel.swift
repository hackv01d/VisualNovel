//
//  GameViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 20.03.2023.
//

import Foundation

final class GameViewModel {
    typealias Factory = StageRepositoryFactory
    
    private let factory: Factory
    private lazy var stageRepository = factory.makeStageRepository()
    
    private let stageId: Int
    
    init(factory: Factory, stageId: Int) {
        self.factory = factory
        self.stageId = stageId
    }
}
