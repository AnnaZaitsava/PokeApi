//
//  LocalizableStrings.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 25.02.24.
//

import Foundation

//struct LocalizableStrings {
//    static let nameLabel = NSLocalizedString("Name", comment: "")
//    static let typeLabel = NSLocalizedString("Type", comment: "")
//    static let weightLabel = NSLocalizedString("Weight", comment: "")
//    static let heightLabel = NSLocalizedString("Height", comment: "")
//}
//
//enum Strings {
//    case nameLabel
//    case typeLabel
//    case weightLabel
//    case heightLabel
//
//    var localizedString: String {
//        switch self {
//        case .nameLabel:
//            return LocalizableStrings.nameLabel
//        case .typeLabel:
//            return LocalizableStrings.typeLabel
//        case .weightLabel:
//            return LocalizableStrings.weightLabel
//        case .heightLabel:
//            return LocalizableStrings.heightLabel
//        }
//    }
//}

enum Strings: String {
    case nameLabel = "Name"
    case typeLabel = "Type"
    case weightLabel = "Weight"
    case heightLabel = "Height"
    
    public func localized(args: CVarArg...) -> String {
        let localizedString = NSLocalizedString(self.rawValue, comment: "")
        return withVaList(args, { (args) -> String in
            return NSString(format: localizedString, locale: Locale.current, arguments: args) as String
        })
    }
    }
