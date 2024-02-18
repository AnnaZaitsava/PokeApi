//
//  UIView + Extension.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 16.02.24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }
}
