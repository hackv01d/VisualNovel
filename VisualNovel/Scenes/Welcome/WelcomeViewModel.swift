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
    var didUpdateTitle: ((String?) -> Void)?
    var didUpdateName: ((String) -> Void)?
    var didGoToGameScreen: ((Int) -> Void)?
    
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

extension WelcomeViewModel: WelcomeViewModelType {
    func getSceneDetail() {
        loadScene()
    }
    
    func startGame(with userName: String?) {
        guard let userName = userName else { return }
        guard userName.isBlank == false else { return }
        guard let sceneId = scene?.choices.first?.id else { return }
        
        ScenesRepository.updateWelcomeScene(with: sceneId, userName: userName)
        didGoToGameScreen?(sceneId)
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
        didUpdateTitle?(scene?.choices.first?.title)
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
