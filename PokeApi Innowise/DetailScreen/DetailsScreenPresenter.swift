//
//  DetailsScreenPresenter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

protocol DetailedPresentationLogic {
    func presentDetailedInformation(response: Details.displayDetailedInformation.Response)
}

class DetailsScreenPresenter: DetailedPresentationLogic {
    weak var viewController: DetailsDisplayLogic?
    
    // MARK: Do something
    
    func presentDetailedInformation(response: Details.displayDetailedInformation.Response) {
//        let name = response.name
        let height = "\(response.height) cm"
        let weight = "\(response.weight) kg"
        let typesString = response.types.map { $0.type.name }.joined(separator: ", ")
        let viewModel = Details.displayDetailedInformation.ViewModel(
//            name: name,
            height: height,
            weight: weight,
            types: typesString)
        viewController?.updateData(viewModel: viewModel)
    }
}


