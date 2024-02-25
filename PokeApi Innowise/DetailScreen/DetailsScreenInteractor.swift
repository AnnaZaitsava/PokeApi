//
//  DetailsScreenInteractor.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.

import UIKit

protocol DetailedBusinessLogic {
    func fetchDetailedInformation()
}

protocol DetailedDataStore {
    var chosenPokemon: Pokemon? { get set }
}

final class DetailsScreenInteractor: DetailedBusinessLogic, DetailedDataStore {
    var chosenPokemon: Pokemon?
    let network = Network()
    var presenter: DetailedPresentationLogic?
    var realm = RealmService()
    
    func fetchDetailedInformation() {
        if NetworkPathMonitor.shared.getCurrentNetworkStatus() == .connected {
            fetchPokemonDetailsFromNetwork()
        } else {
            fetchPokemonDetailsFromDatabase()
        }
    }
    
    private func fetchPokemonDetailsFromNetwork() {
        guard let pokemonURL = chosenPokemon?.url else {
            presenter?.presentAlert(with: "Error", and: "Failed to fetch Pokemon details. Please check your internet connection and try again later.")
            return
        }
        
        network.fetchPokemonDetails(from: pokemonURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonDetailed):
                    if let officialArtwork = pokemonDetailed.sprites.other.officialArtwork?.frontDefault,
                       let imageURL = URL(string: officialArtwork) {
                        self?.network.loadImage(from: imageURL) { loadedImage in
                            DispatchQueue.main.async {
                                if let image = loadedImage {
                                    let response = DetailsScreenDataFlow.Info.Response(
                                        id: pokemonDetailed.id,
                                        name: pokemonDetailed.name,
                                        height: pokemonDetailed.height,
                                        weight: pokemonDetailed.weight,
                                        types: pokemonDetailed.types,
                                        sprites: image
                                    )
                                    self?.realm.updatePokemonInRealmIfNeeded(response: response)
                                    self?.presenter?.presentDetailedInformation(response: response)
                                } else {
                                    self?.presenter?.presentAlert(with: "Image Not Found", and: "Failed to load image data")
                                }
                            }
                        }
                    } else {
                        self?.presenter?.presentAlert(with: "Error", and: "Image Not Found")
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                    self?.fetchPokemonDetailsFromDatabase()
                }
            }
        }
    }
    
    private func fetchPokemonDetailsFromDatabase() {
        let pokemonsFromDatabase = realm.getPokemonsFromRealm()
        if let pokemon = pokemonsFromDatabase.first(where: { $0.url == chosenPokemon?.url }) {
            if let image = UIImage(data: pokemon.sprites) {
                let response = DetailsScreenDataFlow.Info.Response(
                    id: pokemon.id,
                    name: pokemon.name,
                    height: pokemon.height,
                    weight: pokemon.weight,
                    types: pokemon.types.map { PokemonType(type: TypeInfo(name: $0)) },
                    sprites: image
                )
                self.presenter?.presentDetailedInformation(response: response)
            } else {
                self.presenter?.presentAlert(with: "Image Error", and: "Failed to load image from database")
            }
        } else {
            self.presenter?.presentAlert(with: "Pokemons Not Found", and: "Please connect to the network")
        }
    }
}
