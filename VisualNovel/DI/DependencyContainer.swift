//
//  DependencyContainer.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class DependencyContainer {
    private lazy var scenesRepository = ScenesRepositoryImplementation()
}

// MARK: - ScenesRepositoryFactory

extension DependencyContainer: ScenesRepositoryFactory {
    func makeScenesRepository() -> ScenesRepository {
        return scenesRepository
    }
}

// MARK: - MainViewModelFactory

extension DependencyContainer: MainViewModelFactory {
    func makeMainViewModel(sceneId: Int) -> MainViewModel {
        return MainViewModel(factory: self, sceneId: sceneId)
    }
}

// MARK: - WelcomeViewModelFactory

extension DependencyContainer: WelcomeViewModelFactory {
    func makeWelcomeViewModel(sceneId: Int) -> WelcomeViewModel {
        return WelcomeViewModel(factory: self, sceneId: sceneId)
    }
}

// MARK: - GameViewModelFactory

extension DependencyContainer: GameViewModelFactory {
    func makeGameViewModel(sceneId: Int) -> GameViewModel {
        return GameViewModel(factory: self, sceneId: sceneId)
    }
}

// MARK: - CoordinatorFactory

extension DependencyContainer: CoordinatorFactory {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        return AppCoordinator(window: window, factory: self)
    }
    
    func makeGameCoordinator(navigationController: UINavigationController, sceneId: Int) -> GameCoordinator {
        return GameCoordinator(navigationController: navigationController, factory: self, sceneId: sceneId)
    }
    
    func makeWelcomeCoordinator(navigationController: UINavigationController, sceneId: Int) -> WelcomeCoordinator {
        return WelcomeCoordinator(navigationController: navigationController, factory: self, sceneId: sceneId)
    }
    
    func makeMainCoordinator(navigationController: UINavigationController, sceneId: Int, sceneType: MainSceneType) -> MainCoordinator {
        return MainCoordinator(navigationController: navigationController, factory: self, sceneId: sceneId, sceneType: sceneType)
    }
}
