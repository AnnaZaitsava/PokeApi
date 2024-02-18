//
//  DetailsScreenModels.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit


enum Details {
    
    enum displayDetailedInformation {
        struct Response {
            let name: String
            let height: Int
            let weight: Int
            let types: [PokemonType]
            let sprites: Data
        }
        struct ViewModel {
            let name: String
            let height: String
            let weight: String
            let types: String
            let sprites: UIImage
        }
    }
}
