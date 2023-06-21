//
//  AppCoordinator.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    typealias Factory = CoordinatorFactory
    
    private let factory: Factory
    private let window: UIWindow
    
    init(window: UIWindow, factory: Factory) {
        self.window = window
        self.factory = factory
        super.init(navigationController: UINavigationController())
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showMainScene()
    }
}

// MARK: - Navigation

extension AppCoordinator {
    func showMainScene() {
        let mainCoordinator = factory.makeMainCoordinator(navigationController: navigationController, sceneId: 1, sceneType: .start)
        coordinate(to: mainCoordinator)
    }
}
