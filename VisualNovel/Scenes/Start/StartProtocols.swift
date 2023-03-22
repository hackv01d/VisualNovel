//
//  StartViewModelProtocols.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol StartViewModelType {
    var didUpdateHeader: ((String?) -> Void)? { get set }
    var didUpdateTitle: ((String?) -> Void)? { get set }
    
    func getSceneDetail()
    func moveOn()
}


