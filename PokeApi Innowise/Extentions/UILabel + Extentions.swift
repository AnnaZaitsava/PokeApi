//
//  UILabel + Extention.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 18.02.24.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont? = .bold16(), textColor: UIColor, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}
