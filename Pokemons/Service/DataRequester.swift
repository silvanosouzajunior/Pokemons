//
//  DataRequester.swift
//  Pokemons
//
//  Created by Silvano Junior on 16/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataRequester {

    static func getPokemons(completion : @escaping (_ error: Error?, [Pokemon]?) -> ()) {
        let requestString = URLUtils.baseUrl + URLUtils.pokemonsList
        
        Alamofire.request(requestString).responseJSON(completionHandler: { response in
            
            guard response.result.isSuccess else {
                completion(response.result.error, nil)
                return
            }
            
            if let result = response.result.value {
                let resultJSON = JSON(result).dictionaryValue
                if let resultArray = resultJSON["results"]?.arrayValue {
                    var pokemons = [Pokemon]()
                    
                    for pokemonJSON in resultArray {
                        let name = pokemonJSON["name"].stringValue
                        let url = pokemonJSON["url"].stringValue
                        
                        let pokemon = Pokemon(name: name, url: url)
                        pokemons.append(pokemon)
                    }
                    
                    completion(nil, pokemons)
                }}
        })
    }
}
