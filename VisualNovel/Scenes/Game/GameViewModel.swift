//
//  GameViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 20.03.2023.
//

import Foundation

final class GameViewModel {
    typealias Factory = SceneRepositoryFactory
    
    var didUpdatePrompt: ((String?) -> Void)?
    var didUpdateTitle: ((String?) -> Void)?
    
    private let factory: Factory
    private lazy var sceneRepository = factory.makeSceneRepository()
    
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
        scene?.choices.forEach { print($0.title) }
//        didUpdateTitle?()
    }
    
    func loadScene() {
        sceneRepository.getScene(for: sceneId) { result in
            switch result {
            case .success(let scene):
                self.scene = scene
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
}
