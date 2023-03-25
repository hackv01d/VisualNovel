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
    var didUpdateChoice: ((DialogueLabelStyle, String?, Int) -> Void)?
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
        
        let choices = scene.choices
        let maxChoicesCount = scenesRepository.maxChoicesCount
        let minChoicesCount = scenesRepository.minChoicesCount

        let requiredFlexibleSpacesCount = max(0, maxChoicesCount - choices.count)
        let topFlexibleSpacesCount = Int((Double(requiredFlexibleSpacesCount) / 2.0).rounded(.up))
        let bottomFlexibleSpacesCount = requiredFlexibleSpacesCount - topFlexibleSpacesCount
        
        for _ in 0..<topFlexibleSpacesCount {
            didUpdateChoice?(.flexibleSpace, nil, -1)
        }
        choices.forEach { didUpdateChoice?(.choice, $0.title, $0.id) }
        for _ in 0..<bottomFlexibleSpacesCount {
            didUpdateChoice?(.flexibleSpace, nil, -1)
        }
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
