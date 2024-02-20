//
//  MainScreenPresenter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

protocol MainPresentationLogic {
    func presentFetchedPokemons(response: MainScreenDataFlow.Pokemons.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    func presentFetchedPokemons(response: MainScreenDataFlow.Pokemons.Response) {
        
        let pokemonsArray = response.pokemons
        
        let viewModel = MainScreenDataFlow.Pokemons.ViewModel(
            pokemonListViewModel: pokemonsArray.map { pokemon in
                return MainScreenDataFlow.Pokemons.ViewModel.PokemonList(url: pokemon.url, name: pokemon.name)
            }
        )
        
        viewController?.displayPokemonList(viewModel: viewModel)
    }
}

