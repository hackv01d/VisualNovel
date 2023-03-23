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
    var didGoToWelcomeScene: ((Int) -> Void)?
    
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

extension MainViewModel: MainViewModelType {
    func getSceneDetail() {
        loadScene()
    }
    
    func moveOn() {
        guard let sceneId = scene?.choices.first?.id else { return }
        didGoToWelcomeScene?(sceneId)
    }
}

private extension MainViewModel {
    func updateDetail() {
        didUpdateHeader?(scene?.prompt)
        didUpdateChoice?(scene?.choices.first?.title)
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
