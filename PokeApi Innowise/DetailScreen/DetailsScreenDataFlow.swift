//
//  DetailsScreenDataFlow.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit

enum DetailsScreenDataFlow {
    enum Info {
        struct Response {
            let id: Int
            let name: String
            let height: Int
            let weight: Int
            let types: [PokemonType]
            let sprites: UIImage
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
