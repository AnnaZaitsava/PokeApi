//
//  MainScreenPresenter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

protocol MainPresentationLogic {
    func presentFetchedPokemons(response: MainScreenDataFlow.Pokemons.Response)
    func presentAlert(with title: String, and messsage: String)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    func presentFetchedPokemons(response: MainScreenDataFlow.Pokemons.Response) {
        
        let pokemonsArray = response.pokemons
        
        let viewModel = MainScreenDataFlow.Pokemons.ViewModel(
            pokemonListViewModel: pokemonsArray.map { pokemon in
                return MainScreenDataFlow.Pokemons.ViewModel.PokemonList(url: pokemon.url, name: pokemon.name.capitalized)
            }
        )
        
        viewController?.displayPokemonList(viewModel: viewModel)
    }
    
    func presentAlert(with title: String, and messsage: String) {
        viewController?.displayAlert(with: title, and: messsage)
    }
}

