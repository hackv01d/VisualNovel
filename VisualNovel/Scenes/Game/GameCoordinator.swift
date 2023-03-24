//
//  GameCoordinator.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 21.03.2023.
//

import Foundation
import UIKit

final class GameCoordinator: BaseCoordinator {
    typealias Factory = GameViewModelFactory & CoordinatorFactory
    
    private let factory: Factory
    private let gameViewModel: GameViewModel
    
    init(navigationController: UINavigationController, factory: Factory, sceneId: Int) {
        self.factory = factory
        gameViewModel = factory.makeGameViewModel(sceneId: sceneId)
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        setupBindings()
        
        let viewController = GameViewController(with: gameViewModel)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func selectScene(_ scene: SceneType, sceneId: Int) {
        switch scene {
        case .main(let type):
            showMainScene(with: sceneId, type: type)
        case .game:
            showNextGameScene(with: sceneId)
        case .welcome:
            return
        }
    }
}

// MARK: - Navigation

private extension GameCoordinator {
    func showNextGameScene(with sceneId: Int) {
        gameViewModel.updateData(sceneId: sceneId)
        let viewController = GameViewController(with: gameViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showMainScene(with sceneId: Int, type: MainSceneType) {
        let mainCoordinator = factory.makeMainCoordinator(navigationController: navigationController, sceneId: sceneId, sceneType: type)
        coordinate(to: mainCoordinator)
    }
}

// MARK: - Bindings

private extension GameCoordinator {
    private func setupBindings() {
        gameViewModel.didGoToNextScene = { [weak self] scene, id in
            self?.selectScene(scene, sceneId: id)
        }
    }
}
