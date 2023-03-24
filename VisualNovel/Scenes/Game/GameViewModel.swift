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
    var didUpdateChoice: ((String, Int) -> Void)?
    var didGoToNextScene: ((SceneType, Int) -> Void)?
    
    private let factory: Factory
    private lazy var scenesRepository = factory.makeScenesRepository()
    
    private var sceneId: Int
    private var scene: Scene? {
        didSet {
            updateDetail()
        }
    }
    
    init(factory: Factory, sceneId: Int) {
        self.factory = factory
        self.sceneId = sceneId
    }
    
    func updateData(sceneId: Int) {
        self.sceneId = sceneId
    }
}

extension GameViewModel: GameViewModelType {
    func getSceneDetail() {
        loadScene()
    }
    
    func moveOn(for sceneId: Int?) {
        guard let sceneId = sceneId else { return }
        
        let sceneType = getSceneType(for: sceneId)
        didGoToNextScene?(sceneType, sceneId)
    }
}

private extension GameViewModel {
    func getSceneType(for sceneId: Int) -> SceneType {
        return scenesRepository.isLastMainScene(sceneId: sceneId) ? .main(.last) : .game
    }
    
    func updateDetail() {
        guard let scene = scene else { return }
        
        didUpdatePrompt?(scene.prompt)
        
        if scene.choices.count == 3 {
            for choice in scene.choices {
                didUpdateChoice?(choice.title, choice.id)
            }
        } else if scene.choices.count == 2 {
            didUpdateChoice?("", 0)
            for choice in scene.choices {
                didUpdateChoice?(choice.title, choice.id)
            }
        } else if scene.choices.count == 1 {
            didUpdateChoice?("", 0)
            guard let choice = scene.choices.first else { return }
            didUpdateChoice?(choice.title, choice.id)
            didUpdateChoice?("", 0)
        }
//        
//        for choice in scene.choices {
//            didUpdateChoice?(choice.title, choice.id)
//        }
    }
    
    func loadScene() {
        scenesRepository.getScene(for: sceneId) { result in
            switch result {
            case .success(let scene):
                self.scene = scene
            case .failure(let error):
                print(error.description)
            }
        }
    }
}
