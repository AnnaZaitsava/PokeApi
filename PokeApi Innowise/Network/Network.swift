//
//  Network.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case serverError
    case decodingError
    case noData
    case imageLoadingError
}

struct Network {
    
    func fetchPokemonList(url: String, completion: @escaping (Result<PokemonListResponse, NetworkError>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/pokemon"
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.serverError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemons = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                completion(.success(pokemons))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
    func fetchPokemonDetails(from url: String, completion: @escaping (Result<PokemonDetailed, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemonDetailed = try JSONDecoder().decode(PokemonDetailed.self, from: data)
                completion(.success(pokemonDetailed))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
    func loadImage(from url: URL, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.imageLoadingError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.imageLoadingError))
            }
        }.resume()
    }
}

