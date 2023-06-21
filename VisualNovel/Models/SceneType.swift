//
//  SceneType.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 23.03.2023.
//

import Foundation

enum SceneType {
    case main(MainSceneType)
    case welcome
    case game
}

enum MainSceneType {
    case start
    case last
}
