//
//  GameProtocols.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 21.03.2023.
//

import Foundation

protocol GameViewModelType {
    var didUpdateHeader: ((String?) -> Void)? { get set }
    var didUpdateTitle: ((String?) -> Void)? { get set }
    
    func getStageDetail()
}
