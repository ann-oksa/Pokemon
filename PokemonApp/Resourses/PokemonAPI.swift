//
//  PokemonAPI.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import Foundation

class PokeAPI {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func fetchPokemon(limit: Int = 100, offset: Int = 0, completion: @escaping (Result<[PokemonListItem], Error>) -> Void) {
        var allPokemon: [PokemonListItem] = []
        
        func fetchPage(offset: Int) {
            var urlComponents = URLComponents(url: baseURL.appendingPathComponent("pokemon"), resolvingAgainstBaseURL: true)!
            urlComponents.queryItems = [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)")
            ]
            guard let url = urlComponents.url else {
                completion(.failure(APIError.invalidURL))
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(APIError.invalidResponse))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let pokemonResponse = try decoder.decode(PokemonList.self, from: data)
                    allPokemon.append(contentsOf: pokemonResponse.results)
                    // Check if there are more pages
                    if let nextOffset = pokemonResponse.nextOffset {
                        // Fetch the next page recursively
                        fetchPage(offset: nextOffset)
                    } else {
                        // No more pages, return the result
                        completion(.success(allPokemon))
                    }
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
        fetchPage(offset: offset)
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
    // TODO: without pagination
    //    // Fetch a list of Pokemon with pagination
    //    func fetchPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[PokemonListItem], Error>) -> Void) {
    //        let urlString = "\(baseURL)pokemon?offset=\(offset)&limit=\(limit)"
    //        guard let url = URL(string: urlString) else {
    //            completion(.failure(APIError.invalidURL))
    //            return
    //        }
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let error = error {
    //                completion(.failure(error))
    //                return
    //            }
    //            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //                completion(.failure(APIError.invalidResponse))
    //                return
    //            }
    //            guard let data = data else {
    //                completion(.failure(APIError.noData))
    //                return
    //            }
    //            do {
    //                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
    //                completion(.success(pokemonList.results))
    //            } catch {
    //                completion(.failure(error))
    //            }
    //        }.resume()
    //    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

