//
//  ViewController.swift
//  Pokemons
//
//  Created by Silvano Junior on 16/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DataRequester.getPokemons(completion: { result in })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

