//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet private weak var spriteImageView: UIImageView!
        @IBOutlet private weak var idLabel: UILabel!
        @IBOutlet private weak var nameLabel: UILabel!
        @IBOutlet private weak var weightLabel: UILabel!
        @IBOutlet private weak var heightLabel: UILabel!
        @IBOutlet private weak var typeLabel: UILabel!
        @IBOutlet private weak var statsLabel: UILabel!

    var pokemon: PokemonDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
            guard let pokemonDetail = pokemon else {
                return
            }
        spriteImageView.image = UIImage(named: "logo.svg")
            idLabel.text = "ID: \(pokemonDetail.id)"
            nameLabel.text = "Name: \(pokemonDetail.name)"
            weightLabel.text = "Weight: \(pokemonDetail.weight)"
            heightLabel.text = "Height: \(pokemonDetail.height)"
            typeLabel.text = "Type: \(pokemonDetail.types.map { $0.type.name }.joined(separator: ", "))"
            statsLabel.text = "Stats: \(pokemonDetail.stats.map { "\($0.stat.name): \($0.baseStat)" }.joined(separator: ", "))"
        }

}
