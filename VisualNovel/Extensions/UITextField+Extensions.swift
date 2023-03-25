//
//  UITextField+Padding.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 24.03.2023.
//

import UIKit

extension UITextField {
    func leftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftViewMode = .always
        leftView = paddingView
    }
    
    func placeholderColor(_ color: UIColor?) {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: color ?? .darkGray])
    }
}
