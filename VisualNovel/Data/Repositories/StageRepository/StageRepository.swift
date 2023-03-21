//
//  StageRepository.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol StageRepository {
    func updateWelcomeStage(with stageId: Int, userName: String?)
    func getStage(for stageId: Int, completion: (Result<Stage, StageRepositoryError>) -> Void)
}

