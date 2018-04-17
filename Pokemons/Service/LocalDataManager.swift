//
//  LocalDataManager.swift
//  Pokemons
//
//  Created by Silvano Junior on 16/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import UIKit
import CoreData

class LocalDataManager {
    
    static let shared = LocalDataManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func createNewPokemon(name: String, url: String) -> Pokemon {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Pokemon" , in: context)
        
        let pokemon = NSManagedObject(entity: entity!, insertInto: context) as! Pokemon
        pokemon.setValue(name, forKey: "name")
        pokemon.setValue(url, forKey: "url")
        
        appDelegate.saveContext()
        return pokemon
    }
    
    func fetchPokemons() -> [Pokemon]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let pokemons = try context.fetch(request) as! [Pokemon]
            return pokemons
        } catch {
            return nil
        }
    }
}
