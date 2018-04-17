//
//  PokemonDetailsTableViewController.swift
//  Pokemons
//
//  Created by Silvano Junior on 17/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import UIKit

class PokemonDetailsTableViewController: UITableViewController {
    
    var pokemonStats = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokemon"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PokemonDetailsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonStats.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailSegue", for: indexPath) as! PokemonDetailTableViewCell
        
        let stats = Array(pokemonStats.keys)
        let cellStat = stats[indexPath.row]
        
        cell.statTypeLabel.text = cellStat
        cell.statValueLabel.text = String(pokemonStats[cellStat] ?? 0)
        
        return cell
    }
}
