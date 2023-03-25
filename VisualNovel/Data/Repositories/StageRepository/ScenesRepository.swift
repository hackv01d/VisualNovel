//
//  ScenesRepository.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol ScenesRepository {
    var minChoicesCount: Int { get }
    var maxChoicesCount: Int { get }
    
    func isLastMainScene(sceneId: Int) -> Bool
    func isStartMainScene(sceneId: Int) -> Bool
    
    func updateWelcomeScene(with sceneId: Int, userName: String?)
    func getScene(for sceneId: Int, completion: (Result<Scene, ScenesRepositoryError>) -> Void)
}

