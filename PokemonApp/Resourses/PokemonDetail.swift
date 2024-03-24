//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import Foundation

// MARK: - Pokemon
struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeElement]
    let stats: [Stat]

    let forms: [Species]
    let species: Species
    
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, types, stats, forms, species
    }
}

struct Species: Codable {
    let name: String
    let url: String
}

struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
