//
//  FontHelper.swift
//  SnapKit-Homework
//
//  Created by Олег Романов on 03.03.2022.
//

import UIKit

enum Style: String {
    case light = "Light"
    case bold = "Bold"
    case semibold = "SemiBold"
    case regular = "Regular"
}

extension UIFont {
    static func habibiFont(style: Style, size: CGFloat) -> UIFont {
        UIFont(name: "Habibi-\(style.rawValue)", size: size) ?? UIFont()
    }
}
