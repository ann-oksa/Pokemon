//
//  ViewController.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var pokemonList: [PokemonListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
        fetchPokemonData()
    }
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
    }
    
    private func fetchPokemonData() {
        PokeAPI.shared.fetchPokemon { result in
            switch result {
            case .success(let pokemonList):
                // Update the UI with the fetched Pokemon data
                DispatchQueue.main.async {
                    self.pokemonList = pokemonList
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching Pokemon data: \(error)")
            }
        }
    }
}
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell()}
        let pokemon = pokemonList[indexPath.row]
        cell.configure(with: pokemon)
//        cell.textLabel?.text = pokemon.name
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonList[indexPath.row]
        // Navigate to detail screen or perform desired action for the selected Pokemon
        print("Selected Pokemon: \(selectedPokemon.name)")
    }
}
