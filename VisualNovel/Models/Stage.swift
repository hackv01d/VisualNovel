//
//  Stage.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

struct Stage {
    let id: Int
    var header: String
    let options: [Option]
    var userName: String?
}

struct Option {
    let id: Int
    let title: String
}
