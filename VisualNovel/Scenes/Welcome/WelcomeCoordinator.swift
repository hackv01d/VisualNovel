//
//  WelcomeCoordinator.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class WelcomeCoordinator: BaseCoordinator, AlertPresentable {
    typealias Factory = WelcomeViewModelFactory & CoordinatorFactory
    
    private let factory: Factory
    private let welcomeViewModel: WelcomeViewModel
    
    init(navigationController: UINavigationController, factory: Factory, sceneId: Int) {
        self.factory = factory
        welcomeViewModel = factory.makeWelcomeViewModel(sceneId: sceneId)
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        setupBindings()
        
        let viewController = WelcomeViewController(with: welcomeViewModel)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Navigation 

private extension WelcomeCoordinator {
    func showGameScene(with sceneId: Int) {
        let gameCoordinator = factory.makeGameCoordinator(navigationController: navigationController,
                                                          sceneId: sceneId)
        coordinate(to: gameCoordinator)
    }
}

// MARK: - Bindings

private extension WelcomeCoordinator {
    func setupBindings() {
        welcomeViewModel.didGoToGameScene = { [weak self] sceneId in
            self?.showGameScene(with: sceneId)
        }
        
        welcomeViewModel.showError = { [weak self] description in
            self?.presentErrorAlert(with: description)
        }
    }
}
