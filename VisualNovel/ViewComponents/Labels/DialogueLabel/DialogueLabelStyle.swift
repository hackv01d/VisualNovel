//
//  DialogueLabelStyle.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 22.03.2023.
//

import UIKit

enum DialogueLabelStyle {
    case prompt, choice, flexibleSpace
    
    var opacity: Float {
        switch self {
        case .prompt, .choice:
            return 1
        case .flexibleSpace:
            return 0
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .prompt:
            return .promptLabel
        case .choice:
            return .choiceLabel
        case .flexibleSpace:
            return nil
        }
    }
}

