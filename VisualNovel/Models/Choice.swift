//
//  Choice.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

struct Choice {
    let id: Int
    let header: String
    let options: [Option]
}

struct Option {
    let id: Int
    let title: String
}
