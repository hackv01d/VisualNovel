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
    
    func makeGameCoordinator(navigationController: UINavigationController, sceneId: Int) -> GameCoordinator
    
    func makeWelcomeCoordinator(navigationController: UINavigationController, sceneId: Int) -> WelcomeCoordinator
    
    func makeMainCoordinator(navigationController: UINavigationController, sceneId: Int, sceneType: MainSceneType) -> MainCoordinator
}
