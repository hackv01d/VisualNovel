//
//  WelcomeCoordinator.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class WelcomeCoordinator: BaseCoordinator {
    typealias Factory = WelcomeViewModelFactory & CoordinatorFactory
    
    private let factory: Factory
    private let welcomeViewModel: WelcomeViewModel
    
    init(navigationController: UINavigationController, factory: Factory, stageId: Int) {
        self.factory = factory
        welcomeViewModel = factory.makeWelcomeViewModel(stageId: stageId)
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let viewController = WelcomeViewController(with: welcomeViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
