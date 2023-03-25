//
//  Scene.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

struct Scene {
    let id: Int
    var prompt: String
    let imageName: String
    let choices: [Choice]
    var username: String?
}

struct Choice {
    let id: Int
    let title: String
}
