//
//  String+LengthValid.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 21.03.2023.
//

import Foundation

extension String {
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var isLengthValid: Bool {
        count < 40
    }
}
