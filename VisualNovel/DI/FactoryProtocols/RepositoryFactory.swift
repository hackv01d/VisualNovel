//
//  RepositoryFactory.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol ScenesRepositoryFactory {
    func makeScenesRepository() -> ScenesRepository
}
