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

class DetailsScreenInteractor: DetailedBusinessLogic, DetailedDataStore {
    var chosenPokemon: Pokemon?
    let network = Network()
    var presenter: DetailedPresentationLogic?
    var worker: DetailsScreenWorker?
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
            presenter?.showAlertNoDataInDatabase()
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
                                    if let pngImageData = image.pngData() {
                                        let response = DetailsScreenDataFlow.Info.Response(
                                            id: pokemonDetailed.id,
                                            name: pokemonDetailed.name,
                                            height: pokemonDetailed.height,
                                            weight: pokemonDetailed.weight,
                                            types: pokemonDetailed.types,
                                            sprites: pngImageData
                                        )
                                        self?.realm.updatePokemonInRealmIfNeeded(response: response)
                                        self?.presenter?.presentDetailedInformation(response: response)
                                    } else {
                                        print("Failed to convert image to PNG data")
                                    }
                                } else {
                                    print("Failed to load image")
                                }
                            }
                        }
                    } else {
                        print("Image not found")
                    }
                    
                    print("Data received: \(pokemonDetailed)")
                    
                case .failure(let error):
                    print("Error: \(error)")
                    self?.fetchPokemonDetailsFromDatabase()
                }
            }
        }
    }
    
    private func fetchPokemonDetailsFromDatabase() {
        print("Fetching data from database...")
        let pokemonsFromDatabase = realm.getPokemonsFromRealm()
        if let pokemon = pokemonsFromDatabase.first(where: { $0.url == chosenPokemon?.url }) {
            let response = DetailsScreenDataFlow.Info.Response(
                id: pokemon.id,
                name: pokemon.name,
                height: pokemon.height,
                weight: pokemon.weight,
                types: pokemon.types.map { PokemonType(type: TypeInfo(name: $0)) },
                sprites: pokemon.sprites
            )
            self.presenter?.presentDetailedInformation(response: response)
        } else {
            print("No data found in the database")
        }
    }
}


    
//    func fetchDetailedInformation() {
//        guard let pokemonURL = chosenPokemon?.url else {
//            return
//        }
//
//        let network = Network()
//        network.fetchPokemonDetails(from: pokemonURL) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let pokemonDetailed):
//                    if let officialArtwork = pokemonDetailed.sprites.other.officialArtwork?.frontDefault,
//                       let imageURL = URL(string: officialArtwork) {
//                        network.loadImage(from: imageURL) { loadedImage in
//                            DispatchQueue.main.async {
//                                if let image = loadedImage {
//                                    if let pngImageData = image.pngData() {
//                                        let response = DetailsScreenDataFlow.Info.Response(
//                                            id: pokemonDetailed.id,
//                                            name: pokemonDetailed.name,
//                                            height: pokemonDetailed.height,
//                                            weight: pokemonDetailed.weight,
//                                            types: pokemonDetailed.types,
//                                            sprites: pngImageData
//                                        )
//                                        self?.realm.updatePokemonInRealmIfNeeded(response: DetailsScreenDataFlow.Info.Response(id: response.id, name: response.name, height: response.height, weight: response.weight, types: response.types, sprites: response.sprites))
//                                        self?.presenter?.presentDetailedInformation(response: response)
//                                    } else {
//                                        print("Failed to convert image to PNG data")
//                                    }
//                                } else {
//                                    print("Failed to load image")
//                                }
//                            }
//                        }
//                    } else {
//                        print("Image not founded")
//                    }
//
//                    print("Data received: \(pokemonDetailed)")
//
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//        }
//    }
//}
