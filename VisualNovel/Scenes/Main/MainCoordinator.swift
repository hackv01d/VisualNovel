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
    private var mainViewModel: MainViewModel
    private let sceneType: MainSceneType
    
    init(navigationController: UINavigationController, factory: Factory, sceneId: Int, sceneType: MainSceneType) {
        self.factory = factory
        self.sceneType = sceneType
        mainViewModel = factory.makeMainViewModel(sceneId: sceneId)
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        setupBindings()
        
        navigationController.navigationBar.isHidden = true
        sceneType == .start ? showStartMainScene() : showLastMainScene()
    }
    
    private func showErrorAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.present(alertController, animated: true)
    }
    
    private func selectScene(_ scene: SceneType, sceneId: Int) {
        switch scene {
        case .main(let type):
            mainViewModel.updateData(sceneId: sceneId)
            
            if type == .start {
                resetCoordinatorCycle()
                showStartMainScene()
            } else {
                showLastMainScene()
            }
            
        case .welcome:
            showWelcomeScene(with: sceneId)
        case .game:
            return
        }
    }
    
    private func resetCoordinatorCycle() {
        var currentCoordinator = rootCoordinator
        
        while currentCoordinator?.rootCoordinator != nil {
            currentCoordinator = currentCoordinator?.rootCoordinator
        }
        
        if let appCoordinator = currentCoordinator as? AppCoordinator {
            appCoordinator.removeChildCoordinators()
            self.rootCoordinator = appCoordinator
            appCoordinator.childCoordinators.append(self)
        }
    }
}

// MARK: - Navigation

private extension MainCoordinator {
    func showStartMainScene() {
        let viewController = MainViewController(with: mainViewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func showLastMainScene() {
        let viewController = MainViewController(with: mainViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showWelcomeScene(with sceneId: Int) {
        let welcomeCoordinator = factory.makeWelcomeCoordinator(navigationController: navigationController, sceneId: sceneId)
        coordinate(to: welcomeCoordinator)
    }
}

// MARK: - Bindings

private extension MainCoordinator {
    func setupBindings() {
        mainViewModel.didGoToNextScene = { [weak self] scene, sceneId in
            self?.selectScene(scene, sceneId: sceneId)
        }
    }
}
