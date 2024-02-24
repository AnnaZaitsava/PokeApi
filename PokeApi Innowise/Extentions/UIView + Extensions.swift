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

extension UIView {
    static func makeBgView(bgColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        view.layer.cornerRadius = 15
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 40),
            view.widthAnchor.constraint(equalToConstant: 154)
        ])
        return view
    }
}
