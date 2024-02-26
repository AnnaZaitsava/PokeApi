//
//  LocalizableStrings.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 25.02.24.
//

import Foundation

enum Strings: String {
    case nameLabel = "Name"
    case typeLabel = "Type"
    case weightLabel = "Weight"
    case heightLabel = "Height"
    case okButton = "OKButton"
    case navBarTitle = "NavBarTitle"
    
    public var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
