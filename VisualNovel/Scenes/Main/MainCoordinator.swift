//
//  MainCoordinator.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator {
    typealias Factory = MainViewModelFactory & CoordinatorFactory
    
    private let factory: Factory
    private let startViewModel: MainViewModel
    
    init(navigationController: UINavigationController, factory: Factory, sceneId: Int = 1) {
        self.factory = factory
        startViewModel = factory.makeMainViewModel(sceneId: sceneId)
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        setupBindings()
        
        let viewController = MainViewController(with: startViewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}

// MARK: - Navigation

extension MainCoordinator {
    func showWelcomeScene(with sceneId: Int) {
        let welcomeCoordinator = factory.makeWelcomeCoordinator(navigationController: navigationController, sceneId: sceneId)
        coordinate(to: welcomeCoordinator)
    }
}

// MARK: - Bindings

private extension MainCoordinator {
    func setupBindings() {
        startViewModel.didGoToWelcomeScene = { [weak self] sceneId in
            self?.showWelcomeScene(with: sceneId)
        }
    }
}
