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
            guard let pokemonURL = chosenPokemon?.url else {
                return
            }
    //
    //
    //
    //        let network = Network()
    //        network.fetchPokemonDetails(from: pokemonURL) { [weak self] result in
    //            DispatchQueue.main.async {
    //                switch result {
    //                case .success(let pokemonDetailed):
    //                    guard let imageURLString = pokemonDetailed.sprites.other.officialArtwork.frontDefault,
    //                          let imageURL = URL(string: imageURLString) else {
    //                        print("Failed to get image URL")
    //                        return
    //                    }
    //
    //                    network.loadImage(for: imageURL) { imageResult in
    //                        DispatchQueue.main.async {
    //                            switch imageResult {
    //                            case .success(let image):
    //                                let response = Details.displayDetailedInformation.Response(
    //                                    height: pokemonDetailed.height,
    //                                    weight: pokemonDetailed.weight,
    //                                    types: pokemonDetailed.types,
    //                                    sprites: image
    //                                )
    //                                self?.presenter?.presentDetailedInformation(response: response)
    //                            case .failure(let error):
    //                                // Обработка ошибки загрузки изображения
    //                                print("Error loading image: \(error)")
    //                            }
    //                        }
    //                    }
    //
    //                case .failure(let error):
    //                    print("Error fetching pokemon details: \(error)")
    //                }
    //            }
    //        }
    //    }
    //}
    
//    func fetchDetailedInformation() {
//        guard let pokemonURLString = chosenPokemon?.url,
//              let pokemonURL = URL(string: pokemonURLString) else {
//            return
//        }
//
//        let network = Network()
//        network.fetchPokemonDetails(from: pokemonURL) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let pokemonDetailed):
//                    if let imageURLString = pokemonDetailed.sprites.other.officialArtwork.frontDefault,
//                       let imageURL = URL(string: imageURLString) {
//                        network.loadImage(for: imageURL) { imageResult in
//                            DispatchQueue.main.async {
//                                switch imageResult {
//                                case .success(let image):
//                                    // Преобразование изображения в данные формата PNG
//                                    if let pngImageData = image.pngData() {
//                                        let response = Details.displayDetailedInformation.Response(
//                                            height: pokemonDetailed.height,
//                                            weight: pokemonDetailed.weight,
//                                            types: pokemonDetailed.types,
//                                            sprites: pngImageData // Передача данных изображения вместо объекта UIImage
//                                        )
//                                        self?.presenter?.presentDetailedInformation(response: response)
//                                    } else {
//                                        print("Failed to convert image to PNG data")
//                                    }
//                                case .failure(let error):
//                                    // Обработка ошибки загрузки изображения
//                                    print("Error loading image: \(error)")
//                                }
//
//



        let network = Network()
        network.fetchPokemonDetails(from: pokemonURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonDetailed):
                    let response = Details.displayDetailedInformation.Response(
                        height: pokemonDetailed.height,
                        weight: pokemonDetailed.weight,
                        types: pokemonDetailed.types
                    )
                    self?.presenter?.presentDetailedInformation(response: response)

                case .failure(let error):
                    print("Ошибка при получении информации о покемоне: \(error)")
                }
            }
        }
    }
}


