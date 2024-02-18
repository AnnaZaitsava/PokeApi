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
    
    
    
    func fetchDetailedInformation() {
        guard let pokemonURL = chosenPokemon?.url, let pokemonName = chosenPokemon?.name else {
            return
        }

        let network = Network()
        network.fetchPokemonDetails(from: pokemonURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonDetailed):
                    if let officialArtwork = pokemonDetailed.sprites.other.officialArtwork?.frontDefault,
                       let imageURL = URL(string: officialArtwork) {
                        network.loadImage(from: imageURL) { loadedImage in
                            DispatchQueue.main.async {
                                if let image = loadedImage {
                                    if let pngImageData = image.pngData() {
                                        let response = Details.displayDetailedInformation.Response(
                                            name: pokemonName,
                                            height: pokemonDetailed.height,
                                            weight: pokemonDetailed.weight,
                                            types: pokemonDetailed.types,
                                            sprites: pngImageData
                                        )
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
                        print("Image not founded")
                    }
                    
                    print("Data received: \(pokemonDetailed)")
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
