//
//  MainScreenInteractor.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.


import Foundation

protocol MainLogic {
    func fetchPokemons(request: MainScreenDataFlow.Pokemons.Request)
    func saveSelectedItem(pokemon: MainScreenDataFlow.Pokemons.ViewModel.PokemonList)
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
    private var nextPageUrl: String?
    var realm = RealmService()
    
    // MARK: class functions
    
    func fetchPokemons(request: MainScreenDataFlow.Pokemons.Request) {
        if NetworkPathMonitor.shared.getCurrentNetworkStatus() == .connected {
            fetchDataFromNetwork()
        } else {
            fetchDataFromDatabase()
        }
    }
    
    private func fetchDataFromNetwork() {
        let url = nextPageUrl ?? "https://pokeapi.co/api/v2/pokemon"
        network.fetchPokemonList(url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    let pokemons = result.results
                    self?.pokemons += pokemons
                    let response = MainScreenDataFlow.Pokemons.Response(next: result.next ?? "", pokemons: self?.pokemons ?? [])
                    
                    for pokemon in pokemons {
                        self?.realm.savePokemonToRealm(url: pokemon.url, name: pokemon.name) { success in
                            if success {
                                print("Pokemon saved successfully.")
                            } else {
                                print("Failed to save Pokemon.")
                            }
                        }
                    }
                    self?.presenter?.presentFetchedPokemons(response: response)
                    
                    if let nextPageUrl = result.next {
                        self?.nextPageUrl = nextPageUrl
                    }
                    
                case .failure(_):
                    self?.presenter?.presentAlert(with: "Pokemons Not Found", and: "Please connect to the network")
                }
            }
        }
    }
    
    private func fetchDataFromDatabase() {
        let savedPokemons = realm.getPokemonsFromRealm()
        let pokemons = savedPokemons.map { pokemon -> Pokemon in
            return Pokemon(url: pokemon.url, name: pokemon.name)
        }
        
        if !pokemons.isEmpty {
            let response = MainScreenDataFlow.Pokemons.Response(next: "", pokemons: pokemons)
            presenter?.presentFetchedPokemons(response: response)
        } else {
            presenter?.presentAlert(with: "Pokemons Not Found", and: "Please, pull to refresh data\nor check your internet connection")
        }
    }
    
    
    func saveSelectedItem(pokemon: MainScreenDataFlow.Pokemons.ViewModel.PokemonList) {
        chosenPokemon = pokemons.first { $0.url == pokemon.url }
    }
}


