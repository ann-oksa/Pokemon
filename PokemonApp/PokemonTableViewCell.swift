//
//  PokemonTableViewCell.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PokemonCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with pokemon: PokemonListItem) {
        idLabel.text = "ID: \(pokemon.url)"
        nameLabel.text = pokemon.name
        pokemonImageView.image = UIImage(named: "ball")
        // Load sprite image asynchronously
        //        DispatchQueue.global().async {
        //            if let imageUrl = URL(string: pokemon.image) {
        //                if let data = try? Data(contentsOf: imageUrl) {
        //                    DispatchQueue.main.async {
        //                        self.pokemonImageView.image = UIImage(data: data)
        //                    }
        //                }
        //            }
        //        }
    }
}
