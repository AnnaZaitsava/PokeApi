//
//  DetailsScreenPresenter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit

protocol DetailedPresentationLogic {
    func presentDetailedInformation(response: DetailsScreenDataFlow.Info.Response)
    func showAlertNoDataInDatabase()
}

class DetailsScreenPresenter: DetailedPresentationLogic {
    weak var viewController: DetailsDisplayLogic?
    
    func presentDetailedInformation(response: DetailsScreenDataFlow.Info.Response) {
        let height = "\(response.height * 10) cm"
        let weight = "\(response.weight / 10) kg"
        let typesString = response.types.map { $0.type.name }.joined(separator: ", ")
        
        if let image = UIImage(data: response.sprites) {
            let viewModel = DetailsScreenDataFlow.Info.ViewModel(
                name: response.name,
                height: height,
                weight: weight,
                types: typesString,
                sprites: image
            )
            viewController?.displayData(viewModel: viewModel)
        } else {
            print("Failed to convert image")
        }
    }
    
    func showAlertNoDataInDatabase() {
        guard let viewController = viewController as? UIViewController else {
            return
        }
        
        let alert = UIAlertController(title: "Pokemons Not Found", message: "Please connect to the network", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}



