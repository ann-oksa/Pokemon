//
//  PokemonAPI.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import Foundation

class PokeAPI {
    
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    // Fetch a list of Pokemon with pagination
    func fetchPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[PokemonListItem], Error>) -> Void) {
        let urlString = "\(baseURL)pokemon?offset=\(offset)&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                completion(.success(pokemonList.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Fetch detailed data for a specific Pokemon by ID
    func fetchPokemonDetail(pokemonId: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        let urlString = "\(baseURL)pokemon/\(pokemonId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                completion(.success(pokemonDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

