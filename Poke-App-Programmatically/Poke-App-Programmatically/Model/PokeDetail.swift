//
//  PokeDetail.swift
//  Poke-App-Programmatically
//
//  Created by Burak Erden on 19.04.2023.
//

import Foundation

// MARK: - PokeDetail
struct PokeDetail: Codable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let baseExperience: Int
    let sprite: Sprites
    let abilities: [Ability]
    let types: [TypeElement]?
    let stats: [Stat]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, weight, height, abilities, types, stats
        case baseExperience = "base_experience"
        case sprite = "sprites"
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String?
    let backShiny: String?
    let frontDefault: String?
    let frontShiny: String?
    let other: Other?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case other
    }

    init(backDefault: String?, backShiny: String?, frontDefault: String?, frontShiny: String?, other: Other?) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
        self.other = other

    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
}


// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int?
    let version: Species?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld?


    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: Species?
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: Species?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
