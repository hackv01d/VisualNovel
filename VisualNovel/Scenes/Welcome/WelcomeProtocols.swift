//
//  WelcomeProtocols.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol WelcomeViewModelType {
    var didUpdatePrompt: ((String?) -> Void)? { get set }
    var didUpdateChoice: ((String?) -> Void)? { get set }
    var didUpdateName: ((String) -> Void)? { get set }
    
    func getSceneDetail()
    func checkLengthValid(_ name: String?)
    func startGame(with userName: String?)
}
