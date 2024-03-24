//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import Foundation

//struct PokemonDetail: Codable {
//    let name: String
//    let image: String?
//    let id: Int
//    let weight: Double
//    let height: Double
//    let type: String
//    let stats: String
//}
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
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, types, stats, forms, species, sprites
    }
}

struct Species: Codable {
    let name: String
    let url: String
}

class Sprites: Codable {
//    let backDefault: String
//    let backFemale: String?
//    let backShiny: String
//    let backShinyFemale: String?
//    let frontDefault: String
//    let frontFemale: String?
//    let frontShiny: String
//    let frontShinyFemale: String?
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
