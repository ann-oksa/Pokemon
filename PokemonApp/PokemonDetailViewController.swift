//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: PokemonDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setupUI()
    }
    
    private func setupUI() {
        if let pokemon = pokemon {
            print(pokemon.height, pokemon.name)
//                    nameLabel.text = pokemon.name
//                    idLabel.text = "ID: \(pokemon.id)"
//                    // Load sprite image asynchronously
//                    DispatchQueue.global().async {
//                        if let imageUrl = URL(string: pokemon.spriteImageUrl),
//                           let data = try? Data(contentsOf: imageUrl),
//                           let image = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                self.spriteImageView.image = image
//                            }
//                        }
//                    }
//                    // Add more code to update additional details
                }
    }

}
