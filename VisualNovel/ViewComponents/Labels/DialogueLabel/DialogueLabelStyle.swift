//
//  DialogueLabelStyle.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 22.03.2023.
//

import UIKit

enum DialogueLabelStyle {
    case prompt, choice
    
    var backgroundColor: UIColor? {
        switch self {
        case .prompt:
            return .promptLabel
        case .choice:
            return .choiceLabel
        }
    }
}

