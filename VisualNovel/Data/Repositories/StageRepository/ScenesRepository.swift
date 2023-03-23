//
//  ScenesRepository.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol ScenesRepository {
    func updateWelcomeScene(with sceneId: Int, userName: String?)
    func getScene(for sceneId: Int, completion: (Result<Scene, ScenesRepositoryError>) -> Void)
}

