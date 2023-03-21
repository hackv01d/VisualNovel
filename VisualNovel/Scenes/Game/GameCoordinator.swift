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
    
    init(navigationController: UINavigationController, factory: Factory, stageId: Int) {
        self.factory = factory
        gameViewModel = factory.makeGameViewModel(stageId: stageId)
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let viewController = GameViewController(with: gameViewModel)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
