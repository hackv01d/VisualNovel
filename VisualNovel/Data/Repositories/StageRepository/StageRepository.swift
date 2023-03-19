//
//  StageRepository.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol StageRepository {
    func getStage(for stageId: Int, completion: (Result<Stage, StageRepositoryError>) -> Void)
}

