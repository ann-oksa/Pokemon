//
//  PokemonList.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int
    let nextOffset: Int?
    let previous: String?
    let results: [PokemonListItem]
}

// MARK: - Result
struct PokemonListItem: Codable {
    let name: String
    let url: String
    var image: String?
}
