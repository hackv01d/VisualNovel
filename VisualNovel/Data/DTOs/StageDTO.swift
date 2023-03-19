//
//  StageDTO.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

struct StageDTO: Decodable {
    let id: Int
    let header: String
    let options: [OptionDTO]
    
    func toStage() -> Stage {
        return Stage(id: id, header: header, options: options.map { $0.toOption() })
    }
}

struct OptionDTO: Decodable {
    let id: Int
    let title: String
    
    func toOption() -> Option {
        return Option(id: id, title: title)
    }
}

struct StageResponse: Decodable {
    let stages: [StageDTO]
}
