//
//  SceneDTO.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

struct SceneDTO: Decodable {
    let id: Int
    let prompt: String
    let choices: [ChoiceDTO]
    
    func toScene() -> Scene {
        return Scene(id: id, prompt: prompt, choices: choices.map { $0.toChoice() })
    }
}

struct ChoiceDTO: Decodable {
    let id: Int
    let title: String
    
    func toChoice() -> Choice {
        return Choice(id: id, title: title)
    }
}

struct SceneResponse: Decodable {
    let scenes: [SceneDTO]
}
