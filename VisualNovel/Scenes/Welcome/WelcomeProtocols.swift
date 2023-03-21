//
//  WelcomeProtocols.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol WelcomeViewModelType {
    var didUpdateHeader: ((String?) -> Void)? { get set }
    var didUpdateTitle: ((String?) -> Void)? { get set }
    var didUpdateName: ((String) -> Void)? { get set }
    
    func getStageDetail()
    func checkLengthValid(_ name: String?)
    func startGame(with userName: String?)
}
