//
//  MainScreenPresenter.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

protocol MainPresentationLogic {
    func displayFetchedPokemons(response: Main.displayPokemons.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    func displayFetchedPokemons(response: Main.displayPokemons.Response) {
        
        let pokemonsArray = response.pokemons
              
              let viewModel = Main.displayPokemons.ViewModel(
                  pokemonListViewModel: pokemonsArray.map { pokemon in
                      return Main.displayPokemons.ViewModel.pokemonList(url: pokemon.url, name: pokemon.name)
                  }
              )
              
              viewController?.updatePokemonList(viewModel: viewModel)
          }
      }

