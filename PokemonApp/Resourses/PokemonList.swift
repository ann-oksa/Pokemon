//
//  PokemonList.swift
//  PokemonApp
//
//  Created by mac on 24.03.2024.
//

import Foundation

struct PokemonDetail: Codable {
    let name: String
    let image: String?
    let id: String
    let weight: Double
    let height: Double
    let type: String
    let stats: String
}

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int
    let nextOffset: Int?
    let previous: JSONNull?
    let results: [PokemonListItem]
}

// MARK: - Result
struct PokemonListItem: Codable {
    let name: String
    let url: String
    var image: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
