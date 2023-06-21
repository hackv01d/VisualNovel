//
//  Localizable.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 25.03.2023.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var tableName: String {
        "Localizable"
    }
    
    var localized: String {
        rawValue.localized(tableName: tableName)
    }
    
    func callAsFunction() -> String {
        self.localized
    }
}
