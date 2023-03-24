//
//  ViewModelFactory.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol MainViewModelFactory {
    func makeMainViewModel(sceneId: Int) -> MainViewModel
}

protocol WelcomeViewModelFactory {
    func makeWelcomeViewModel(sceneId: Int) -> WelcomeViewModel
}

protocol GameViewModelFactory {
    func makeGameViewModel(sceneId: Int) -> GameViewModel
}
