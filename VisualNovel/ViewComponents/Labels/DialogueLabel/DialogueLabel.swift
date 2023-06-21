//
//  DialogueLabel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 22.03.2023.
//

import UIKit

final class DialogueLabel: UILabel {
    
    init(style: DialogueLabelStyle) {
        super.init(frame: .zero)
        setup(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(style: DialogueLabelStyle) {
        font = .gamePrompt
        textColor = .appText
        textAlignment = .center
        layer.opacity = style.opacity
        adjustsFontSizeToFitWidth = true
        backgroundColor = style.backgroundColor
    }
}
