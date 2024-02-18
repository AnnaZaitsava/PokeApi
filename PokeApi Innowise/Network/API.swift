//
//  API.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 17.02.24.
//

import Foundation

struct PokemonListResponse: Codable {
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let url: String
    let name: String
}

struct PokemonDetailed: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let sprites: Sprites
}

struct PokemonType: Codable {
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
}

struct Sprites: Codable {
    let other: Other
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
