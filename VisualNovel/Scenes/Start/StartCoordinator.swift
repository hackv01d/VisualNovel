//
//  StartCoordinator.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class StartCoordinator: BaseCoordinator {
    typealias Factory = StartViewModelFactory & CoordinatorFactory
    
    private let factory: Factory
    private let startViewModel: StartViewModel
    
    init(navigationController: UINavigationController, factory: Factory, sceneId: Int = 1) {
        self.factory = factory
        startViewModel = factory.makeStartViewModel(sceneId: sceneId)
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        setupBindings()
        
        let viewController = StartViewController(with: startViewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}

// MARK: - Navigation

extension StartCoordinator {
    func showWelcomeScene(with sceneId: Int) {
        let welcomeCoordinator = factory.makeWelcomeCoordinator(navigationController: navigationController, sceneId: sceneId)
        coordinate(to: welcomeCoordinator)
    }
}

// MARK: - Bindings

private extension StartCoordinator {
    func setupBindings() {
        startViewModel.didGoToNextScreen = { [weak self] sceneId in
            self?.showWelcomeScene(with: sceneId)
        }
    }
}
