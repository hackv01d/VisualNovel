//
//  CoordinatorFactory.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

protocol CoordinatorFactory {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator
    func makeStartCoordinator(navigationController: UINavigationController) -> StartCoordinator
    func makeWelcomeCoordinator(navigationController: UINavigationController, stageId: Int) -> WelcomeCoordinator
}
