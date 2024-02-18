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

    func fetchData(completion:  @escaping Completion) {
        let urlRequest = URLRequest(url: url ?? URL(fileURLWithPath: ""))
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
                    let characters = try? JSONDecoder().decode(PokemonListResponse.self, from: data)
                    guard let result = characters else {
                        return
                    }
                    completion(.success(result))
                }
            }
        )
        task.resume()
    }
}
