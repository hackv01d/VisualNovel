//
//  MainViewModelProtocols.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol MainViewModelType {
    var didUpdateHeader: ((String?) -> Void)? { get set }
    var didUpdateChoice: ((String?) -> Void)? { get set }
    
    func getSceneDetail()
    func moveOn()
}


