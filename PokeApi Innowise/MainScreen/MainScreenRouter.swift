//
//  MainScreenRouter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

@objc protocol MainRoutingLogic {
    func routeToDetailedViewController()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

final class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    // MARK: Routing
    
    func routeToDetailedViewController() {
        let destinationViewController = DetailsScreenViewController()
        
        var destinationDataSource = destinationViewController.router!.dataStore!
        passDataToSomewhere(source: dataStore!, destination: &destinationDataSource)
        navigateToDetails(source: viewController!, destination: destinationViewController)        
    }
    
    // MARK: Navigation
    
    func navigateToDetails(
        source: MainViewController,
        destination: DetailsScreenViewController) {
            source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func passDataToSomewhere(
        source: MainDataStore,
        destination: inout DetailedDataStore) {
            destination.chosenPokemon = source.chosenPokemon
            print("\(String(describing: source.chosenPokemon?.url))")
    }

}
