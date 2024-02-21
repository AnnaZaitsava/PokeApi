//
//  Realm.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 20.02.24.
//

import Foundation
import RealmSwift

class ItemPokemon: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var weight: Int = 0
    let types = List<String>()
    @objc dynamic var sprites: Data = Data()
}

class RealmService {
    private let realm = try! Realm()

    func savePokemonToRealm(url: String, name: String, completion: @escaping (Bool) -> Void) {
            do {
                if realm.objects(ItemPokemon.self).filter("name == %@", name).isEmpty {
                    let newPokemon = ItemPokemon()
                    newPokemon.url = url
                    newPokemon.name = name
                    try realm.write {
                        realm.add(newPokemon)
                    }
                    print("Pokemon with name \(name) has been saved to the database.")
                    completion(true)
                } else {
                    print("Pokemon with name \(name) already exists in the database.")
                    completion(false)
            }
        } catch {
            print("Error saving pokemon to Realm: \(error)")
            completion(false)
        }
    }
    
    func updatePokemonInRealmIfNeeded(response: DetailsScreenDataFlow.Info.Response) {
        do {
            if let existingPokemon = realm.objects(ItemPokemon.self).filter("name == %@", response.name).first {
                try realm.write {
                    existingPokemon.name = response.name
                    existingPokemon.height = response.height
                    existingPokemon.weight = response.weight
                    existingPokemon.types.removeAll()
                    // Convert PokemonType objects to strings
                    for pokemonType in response.types {
                        existingPokemon.types.append(pokemonType.type.name)
                    }
                    // Save image data if available
                    if let imageData = response.sprites.pngData() {
                        existingPokemon.sprites = imageData
                    }
                }
                print("Pokemon with name \(response.name) has been updated in the database.")
            } else {
                print("Pokemon with name \(response.name) not found in the database.")
            }
        } catch {
            print("Error updating pokemon in Realm: \(error)")
        }
    }

    func getPokemonsFromRealm() -> [ItemPokemon] {
        let pokemons = realm.objects(ItemPokemon.self)
        return Array(pokemons)
    }
}

