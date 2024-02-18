//
//  DetailsScreenPresenter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit

protocol DetailedPresentationLogic {
    func presentDetailedInformation(response: Details.displayDetailedInformation.Response)
}

class DetailsScreenPresenter: DetailedPresentationLogic {
    weak var viewController: DetailsDisplayLogic?
    
    func presentDetailedInformation(response: Details.displayDetailedInformation.Response) {
        let height = "\(response.height) cm"
        let weight = "\(response.weight) kg"
        let typesString = response.types.map { $0.type.name }.joined(separator: ", ")
        
        if let image = UIImage(data: response.sprites) {
            let viewModel = Details.displayDetailedInformation.ViewModel(
                name: response.name,
                height: height,
                weight: weight,
                types: typesString,
                sprites: image
            )
            viewController?.updateData(viewModel: viewModel)
        } else {
            print("Failed to convert image")
        }
    }
}



