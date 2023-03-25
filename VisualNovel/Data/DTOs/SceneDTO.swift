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
    let imageName: String
    let choices: [ChoiceDTO]
    
    private enum CodingKeys: String, CodingKey {
        case id, prompt, choices
        case imageName = "image_name"
    }
    
    func toScene() -> Scene {
        return Scene(id: id, prompt: prompt, imageName: imageName, choices: choices.map { $0.toChoice() })
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
