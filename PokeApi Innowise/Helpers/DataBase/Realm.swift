//
//  Realm.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 20.02.24.
//

import Foundation
import RealmSwift

class ItemPokemon: Object {
    @Persisted var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var url: String = ""
    @Persisted var height: Int = 0
    @Persisted var weight: Int = 0
    let types = List<String>()
    @Persisted var sprites: Data
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
    
//    func updatePokemonInRealmIfNeeded(response: DetailsScreenDataFlow.Info.Response) {
//        do {
//            if let existingPokemon = realm.objects(ItemPokemon.self).filter("name == %@", response.name).first {
//                try realm.write {
//                    existingPokemon.name = response.name
//                    existingPokemon.height = response.height
//                    existingPokemon.weight = response.weight
//                    existingPokemon.types.removeAll()
//                    existingPokemon.types.append(objectsIn: response.types.map { $0.type.name })
//                    existingPokemon.sprites = response.sprites
//                }
//                print("Pokemon with name \(response.name) has been updated in the database.")
//            } else {
//                print("Pokemon with name \(response.name) not found in the database.")
//            }
//        } catch {
//            print("Error updating pokemon in Realm: \(error)")
//        }
//    }
    
    func updatePokemonInRealmIfNeeded(response: DetailsScreenDataFlow.Info.Response) {
        do {
            if let existingPokemon = realm.objects(ItemPokemon.self).filter("name == %@", response.name).first {
                try realm.write {
                    existingPokemon.name = response.name
                    existingPokemon.height = response.height
                    existingPokemon.weight = response.weight
                    existingPokemon.types.removeAll()
                    for pokemonType in response.types {
                        existingPokemon.types.append(pokemonType.type.name)
                    }
                    existingPokemon.sprites = response.sprites
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

