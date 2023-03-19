//
//  DependencyContainer.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class DependencyContainer {
    private lazy var choiceRepositoy = ChoiceRepositoryImpl()
}

// MARK: - ChoiceRepositoryFactory

extension DependencyContainer: ChoiceRepositoryFactory {
    func makeChoiceRepository() -> ChoiceRepository {
        return choiceRepositoy
    }
}
