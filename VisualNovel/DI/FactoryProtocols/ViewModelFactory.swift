//
//  ViewModelFactory.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol StartViewModelFactory {
    func makeStartViewModel(stageId: Int) -> StartViewModel
}

protocol WelcomeViewModelFactory {
    func makeWelcomeViewModel(stageId: Int) -> WelcomeViewModel
}
