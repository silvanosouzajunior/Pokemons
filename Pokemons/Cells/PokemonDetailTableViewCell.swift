//
//  PokemonDetailTableViewCell.swift
//  Pokemons
//
//  Created by Silvano Junior on 17/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import UIKit

class PokemonDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var statValueLabel: UILabel!
    @IBOutlet weak var statTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
