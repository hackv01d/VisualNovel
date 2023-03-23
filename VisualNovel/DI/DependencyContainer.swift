//
//  DependencyContainer.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class DependencyContainer {
    private lazy var ScenesRepository = ScenesRepositoryImplementation()
}

// MARK: - ScenesRepositoryFactory

extension DependencyContainer: ScenesRepositoryFactory {
    func makeScenesRepository() -> ScenesRepository {
        return ScenesRepository
    }
}

// MARK: - StartViewModelFactory

extension DependencyContainer: StartViewModelFactory {
    func makeStartViewModel(sceneId: Int) -> StartViewModel {
        return StartViewModel(factory: self, sceneId: sceneId)
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

    func makeStartCoordinator(navigationController: UINavigationController) -> StartCoordinator {
        return StartCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeWelcomeCoordinator(navigationController: UINavigationController, sceneId: Int) -> WelcomeCoordinator {
        return WelcomeCoordinator(navigationController: navigationController, factory: self, sceneId: sceneId)
    }
    
    func makeGameCoordinator(navigationController: UINavigationController, sceneId: Int) -> GameCoordinator {
        return GameCoordinator(navigationController: navigationController, factory: self, sceneId: sceneId)
    }
}
