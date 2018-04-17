//
//  DataManager.swift
//  Pokemons
//
//  Created by Silvano Junior on 16/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import Foundation

protocol DataManagerDelegate: class {
    func didUpdatePokemons(pokemons: [Pokemon])
    func didUpdatePokemonStats(stats: [String: Int])
}

class DataManager {
    weak var delegate: DataManagerDelegate?
    
    func fetchPokemons() {
        if let pokemons = LocalDataManager.shared.fetchPokemons(), pokemons.count > 0 {
            self.delegate?.didUpdatePokemons(pokemons: pokemons)
        } else {
            ServiceDataRequester.shared.getPokemons(completion: { error, result in
                if let pokemons = result {
                    self.delegate?.didUpdatePokemons(pokemons: pokemons)
                }
            })
        }
    }
    
    func fetchPokemonDetails(pokemon: Pokemon) {
        ServiceDataRequester.shared.updatePokemonWithData(pokemon: pokemon, completion: { result in
            if let result = result {
                self.delegate?.didUpdatePokemonStats(stats: result)
            }
        })

    }
}
