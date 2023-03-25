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
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        NSLocalizedString(self,
                          tableName:tableName,
                          bundle: bundle,
                          value: self,
                          comment: "")
    }
}
