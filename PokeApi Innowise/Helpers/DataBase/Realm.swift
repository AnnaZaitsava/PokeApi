//
//  Realm.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 20.02.24.
//

import Foundation
import RealmSwift

final class ItemPokemon: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var weight: Int = 0
    let types = List<String>()
    @objc dynamic var sprites: Data = Data()
}

final class RealmService {
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
                completion(true)
            } else {
                completion(false)
            }
        } catch {
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
                    for pokemonType in response.types {
                        existingPokemon.types.append(pokemonType.type.name)
                    }
                    if let imageData = response.sprites.pngData() {
                        existingPokemon.sprites = imageData
                    }
                }
            }
        } catch {
        }
    }
    
    func getPokemonsFromRealm() -> [ItemPokemon] {
        let pokemons = realm.objects(ItemPokemon.self)
        return Array(pokemons)
    }
}
