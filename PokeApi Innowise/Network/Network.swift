//
//  Network.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.
//

import UIKit

typealias Completion = ((Result<PokemonListResponse, Error>) -> Void)

struct Network {
    private let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    func fetchPokemonList(url: String, completion: @escaping Completion) {
        guard let url = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(
            with: urlRequest,
            completionHandler: { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(URLError(.cannotDecodeContentData)))
                    return
                }
                
                do {
                    let pokemons = try? JSONDecoder().decode(PokemonListResponse.self, from: data)
                    guard let result = pokemons else {
                        return
                    }
                    completion(.success(result))
                }
            }
        )
        task.resume()
    }
    
    func fetchPokemonDetails(from url: String, completion: @escaping (Result<PokemonDetailed, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            
            do {
                let pokemonDetailed = try JSONDecoder().decode(PokemonDetailed.self, from: data)
                completion(.success(pokemonDetailed))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   print("Error loading image: \(error)")
                   completion(nil)
                   return
               }

               if let data = data, let image = UIImage(data: data) {
                   completion(image)
               } else {
                   print("Error creating image from data")
                   completion(nil)
               }
           }.resume()
       }

}
