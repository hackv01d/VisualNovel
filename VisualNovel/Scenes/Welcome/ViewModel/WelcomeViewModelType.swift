//
//  WelcomeViewModelType.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

protocol WelcomeViewModelType {
    var placeholder: String { get }
    
    var didUpdateName: ((String) -> Void)? { get set }
    var didUpdateChoice: ((String?) -> Void)? { get set }
    var didUpdatePrompt: ((String?) -> Void)? { get set }
    var didUpdateBackground: ((String) -> Void)? { get set }
    
    func getSceneDetail()
    func checkLengthValid(_ name: String?)
    func startGame(with username: String?)
}
