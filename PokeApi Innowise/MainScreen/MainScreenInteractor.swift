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
    var chosenPokemon: Pokemon? { get set }
}

class MainInteractor: MainLogic, MainDataStore {
    
    var presenter: MainPresentationLogic?
    var worker: MainScreenWorker?
    var pokemons: [Pokemon] = []
    var chosenPokemon: Pokemon?
    private let network = Network()
    
    // MARK: class functions
    
    func fetchPokemons(request: Main.displayPokemons.Request) {
        let url = "https://pokeapi.co/api/v2/pokemon"
        fetchPokemons(next: url)
    }
    
    func fetchPokemons(next: String) {
           network.fetchPokemonList(url: next) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let result):
                       let pokemons = result.results
                       self?.pokemons += pokemons
                       let response = Main.displayPokemons.Response(next: result.next ?? "", pokemons: self?.pokemons ?? [])
                       self?.presenter?.displayFetchedPokemons(response: response)
                       
                       // Check if there is a link to the next page and call fetchPokemons with this link
                       if let nextPageUrl = result.next {
                           self?.fetchPokemons(next: nextPageUrl)
                       } else {
                           // Если следующая страница пуста, значит, все данные загружены
                           // Создаем новый объект Response на основе ViewModel и вызываем метод displayFetchedPokemons с ним
                           let newResponse = Main.displayPokemons.Response(next: "", pokemons: self?.pokemons ?? [])
                           self?.presenter?.displayFetchedPokemons(response: newResponse)
                       }
                       
                   case .failure(let failure):
                       print(failure)
                   }
               }
           }
       }
        
        func saveSelectedItem(pokemon: Main.displayPokemons.ViewModel.pokemonList) {
            chosenPokemon = pokemons.first { $0.url == pokemon.url }
        }
    }
    
