//
//  GameViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 20.03.2023.
//

import Foundation

final class GameViewModel {
    typealias Factory = ScenesRepositoryFactory
    
    var didUpdatePrompt: ((String?) -> Void)?
    var didUpdateTitle: ((String?) -> Void)?
    
    private let factory: Factory
    private lazy var ScenesRepository = factory.makeScenesRepository()
    
    private let sceneId: Int
    private var scene: Scene? {
        didSet {
            updateDetail()
        }
    }
    
    init(factory: Factory, sceneId: Int) {
        self.factory = factory
        self.sceneId = sceneId
    }
}

extension GameViewModel: GameViewModelType {
    func getSceneDetail() {
        loadScene()
    }
}

private extension GameViewModel {
    func updateDetail() {
        didUpdatePrompt?(scene?.prompt)
    }
    
    func loadScene() {
        ScenesRepository.getScene(for: sceneId) { result in
            switch result {
            case .success(let scene):
                self.scene = scene
            case .failure(let error):
                print(error.description)
            }
        }
    }
}
