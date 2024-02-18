//
//  MainScreenInteractor.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import UIKit

protocol MainLogic {
    func fetchPokemons(request: Main.displayPokemons.Request)
    func saveSelectedItem(pokemon: Main.displayPokemons.ViewModel.pokemonList)
}

protocol MainDataStore {
    var chosenCharacter: Pokemon? { get set }
}

class MainInteractor: MainLogic, MainDataStore {
    
    var presenter: MainPresentationLogic?
    var worker: MainScreenWorker?
    var pokemons: [Pokemon] = []
    var chosenCharacter: Pokemon?
    private let network = Network()
    
    // MARK: class functions
    
    func fetchPokemons(request: Main.displayPokemons.Request) {
        network.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    let pokemons = result.results
                    self?.pokemons = pokemons
                    let response = Main.displayPokemons.Response(pokemons: pokemons)
                    self?.presenter?.displayFetchedPokemons(response: response)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func saveSelectedItem(pokemon: Main.displayPokemons.ViewModel.pokemonList) {
    }
}
