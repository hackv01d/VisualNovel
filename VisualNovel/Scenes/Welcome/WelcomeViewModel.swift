//
//  WelcomeViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class WelcomeViewModel {
    typealias Factory = StageRepositoryFactory
    
    private let factory: Factory
    private lazy var stageRepository = factory.makeStageRepository()
    
    private let stageId: Int
    private var stage: Stage?
    
    init(factory: Factory, stageId: Int) {
        self.factory = factory
        self.stageId = stageId
    }
}

extension WelcomeViewModel: WelcomeViewModelType {
    
}
