//
//  DetailsScreenRouter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit

@objc protocol DetailedRoutingLogic { }

protocol DetailedDataPassing {
    var dataStore: DetailedDataStore? { get }
}

final class DetailsScreenRouter: NSObject, DetailedRoutingLogic, DetailedDataPassing {
    weak var viewController: DetailsScreenViewController?
    var dataStore: DetailedDataStore?
}
