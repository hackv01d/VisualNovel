//
//  StartViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class StartViewModel {
    
    var didUpdatePrompt: ((String?) -> Void)?
    var didUpdateTitle: ((String?) -> Void)?
    var didGoToNextScreen: ((Int) -> Void)?
    
    typealias Factory = SceneRepositoryFactory
    
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

extension StartViewModel: StartViewModelType {
    func getSceneDetail() {
        loadScene()
    }
    
    func moveOn() {
        guard let sceneId = scene?.choices.first?.id else { return }
        didGoToNextScreen?(sceneId)
    }
}

private extension StartViewModel {
    func updateDetail() {
        didUpdatePrompt?(scene?.prompt)
        didUpdateTitle?(scene?.choices.first?.title)
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
