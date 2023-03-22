//
//  DialogueLabel.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 22.03.2023.
//

import UIKit

class DialogueLabel: UILabel {
    
    init(style: DialogueLabelStyle, text: String = "", tag: Int = 0) {
        super.init(frame: .zero)
        
        self.text = text
        self.tag = tag
        setup(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(style: DialogueLabelStyle) {
        textColor = .white
        font = .gamePrompt
        textAlignment = .center
        backgroundColor = style.backgroundColor
        adjustsFontSizeToFitWidth = true
    }
}
