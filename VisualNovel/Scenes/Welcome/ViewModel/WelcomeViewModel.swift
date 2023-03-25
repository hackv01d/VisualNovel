//
//  WelcomeViewModel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class WelcomeViewModel {
    typealias Factory = ScenesRepositoryFactory
    
    var didUpdatePrompt: ((String?) -> Void)?
    var didUpdateChoice: ((String?) -> Void)?
    var didUpdateName: ((String) -> Void)?
    
    var showError: ((String) -> Void)?
    var didGoToGameScene: ((Int) -> Void)?
    
    private let factory: Factory
    private lazy var scenesRepository = factory.makeScenesRepository()
    private(set) var placeholder = LocalizedStrings.usernamePlaceholder()
    
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

extension WelcomeViewModel: WelcomeViewModelType {
    func getSceneDetail() {
        loadScene()
    }
    
    func startGame(with username: String?) {
        guard let username = username else { return }
        guard username.isBlank == false else { return }
        guard let sceneId = scene?.choices.first?.id else { return }
        
        scenesRepository.updateWelcomeScene(with: sceneId, username: username)
        didGoToGameScene?(sceneId)
    }
    
    func checkLengthValid(_ name: String?) {
        guard var name = name else { return }
        guard name.isLengthValid == false else { return }
        
        name.removeLast()
        didUpdateName?(name)
        return
    }
}

private extension WelcomeViewModel {
    func updateDetail() {
        didUpdatePrompt?(scene?.prompt)
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
