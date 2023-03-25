//
//  MainViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class MainViewModel {
    typealias Factory = ScenesRepositoryFactory
    
    var didUpdateHeader: ((String?) -> Void)?
    var didUpdateChoice: ((String?) -> Void)?
    
    var showError: ((String) -> Void)?
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

extension MainViewModel: MainViewModelType {
    func getSceneDetail() {
        loadScene()
    }
    
    func moveOn() {
        guard let sceneId = scene?.choices.first?.id else { return }
        
        let sceneType = getSceneType(for: sceneId)
        didGoToNextScene?(sceneType, sceneId)
    }
}

private extension MainViewModel {
    func getSceneType(for sceneId: Int) -> SceneType {
        return scenesRepository.isStartMainScene(sceneId: sceneId) ? .main(.start) : .welcome
    }
    
    func updateDetail() {
        didUpdateHeader?(scene?.prompt)
        didUpdateChoice?(scene?.choices.first?.title)
    }
    
    func loadScene() {
        scenesRepository.getScene(for: sceneId) { result in
            switch result {
            case .success(let scene):
                self.scene = scene
            case .failure(let error):
                showError?(error.description)
            }
        }
    }
}
