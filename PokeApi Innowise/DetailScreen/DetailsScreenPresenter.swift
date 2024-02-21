//
//  DetailsScreenPresenter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit

protocol DetailedPresentationLogic {
    func presentDetailedInformation(response: DetailsScreenDataFlow.Info.Response)
    func presentAlert(with title: String, and messsage: String)
}

class DetailsScreenPresenter: DetailedPresentationLogic {
    weak var viewController: DetailsDisplayLogic?
    
    func presentDetailedInformation(response: DetailsScreenDataFlow.Info.Response) {
        let height = "\(response.height * 10) cm"
        let weight = "\(response.weight / 10) kg"
        let typesString = response.types.map { $0.type.name }.joined(separator: ", ")
        
            let viewModel = DetailsScreenDataFlow.Info.ViewModel(
                name: response.name.capitalized,
                height: height,
                weight: weight,
                types: typesString,
                sprites: response.sprites
            )
            viewController?.displayData(viewModel: viewModel)
    }
    
    func presentAlert(with title: String, and messsage: String) {
        viewController?.displayAlert(with: title, and: messsage)
    }
}



