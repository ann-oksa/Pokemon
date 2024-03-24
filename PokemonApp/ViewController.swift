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
    private var isLoadingData = false
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchPokemonData()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
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
   private func fetchNextPage() {
        guard !isLoadingData else { return }
        isLoadingData = true
        currentPage += 1
        
        PokeAPI.shared.fetchPokemon(limit: 20, offset: currentPage * 20) { result in
            switch result {
            case .success(let pokemonList):
                self.pokemonList.append(contentsOf: pokemonList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching Pokemon data: \(error)")
            }
            self.isLoadingData = false
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
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonList[indexPath.row]
        print("Selected Pokemon: \(selectedPokemon.name)")
        PokeAPI.shared.fetchPokemonDetail(pokemonUrl: selectedPokemon.url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonDetail):
                    print("Pokemon Detail: \(pokemonDetail)")
                    if let pokemonDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController {
                        pokemonDetailVC.pokemon = pokemonDetail
                        self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
                    }
                case .failure(let error):
                    print("Error fetching Pokemon detail: \(error)")
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            // Reached bottom of table view, load next page
            fetchNextPage()
        }
    }
}
