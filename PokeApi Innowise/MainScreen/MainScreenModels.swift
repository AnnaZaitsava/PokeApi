//
//  MainScreenModels.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

enum Main {
    
    enum displayPokemons {
        
        struct Request {
        }
        
        struct Response {
            let pokemons: [Pokemon]
        }
        
        struct ViewModel {
            struct pokemonList {
                let url: String
                let name: String
            }
            var pokemonListViewModel: [pokemonList]
        }
    }
}
