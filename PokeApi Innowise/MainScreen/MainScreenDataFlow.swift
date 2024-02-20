//
//  MainScreenDataFlow.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

enum MainScreenDataFlow {
    enum Pokemons {
        struct Request { }
        
        struct Response {
            let next: String
            let pokemons: [Pokemon]
        }
        
        struct ViewModel {
            struct PokemonList {
                let url: String
                let name: String
            }
            let pokemonListViewModel: [PokemonList]
        }
    }
}
