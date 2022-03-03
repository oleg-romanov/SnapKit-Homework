//
//  MessageTextField.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit

class MessageTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 52)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
