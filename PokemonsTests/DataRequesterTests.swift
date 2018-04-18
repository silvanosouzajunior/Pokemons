//
//  DataRequesterTests.swift
//  PokemonsTests
//
//  Created by Silvano Junior on 16/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

@testable import Pokemons
import XCTest

class DataRequesterTests: XCTestCase {
    
    func testGettingPokemonsJSON() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        ServiceDataRequester.shared.getPokemons(completion: { (error, result) in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            ex.fulfill()
            
        })
        
        waitForExpectations(timeout: 15) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}
