//
//  ChoiceRepository.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol ChoiceRepository {
    func getChoice(for choiceId: Int, completion: (Result<Choice, Error>) -> Void)
}

