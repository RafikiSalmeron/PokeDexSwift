// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let jSONPokemon = try? newJSONDecoder().decode(JSONPokemon.self, from: jsonData)

import Foundation

// MARK: - JSONPokemon
struct JSONPokemon: Codable {
    let pokemon: [Pokemon]
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let id: Int
    let num, name: String
    let img: String
    let type: [TypeElement]
    let height, weight, candy: String
    let candyCount: Int?
    let egg: Egg
    let spawnChance, avgSpawns: Double
    let spawnTime: String
    let multipliers: [Double]?
    let weaknesses: [TypeElement]
    let nextEvolution, prevEvolution: [Evolution]?

    enum CodingKeys: String, CodingKey {
        case id, num, name, img, type, height, weight, candy
        case candyCount = "candy_count"
        case egg
        case spawnChance = "spawn_chance"
        case avgSpawns = "avg_spawns"
        case spawnTime = "spawn_time"
        case multipliers, weaknesses
        case nextEvolution = "next_evolution"
        case prevEvolution = "prev_evolution"
    }
}

enum Egg: String, Codable {
    case notInEggs = "Not in Eggs"
    case omanyteCandy = "Omanyte Candy"
    case the10KM = "10 km"
    case the2KM = "2 km"
    case the5KM = "5 km"
}

// MARK: - Evolution
struct Evolution: Codable {
    let num, name: String
}

enum TypeElement: String, Codable {
    case bug = "Bug"
    case dark = "Dark"
    case dragon = "Dragon"
    case electric = "Electric"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case ice = "Ice"
    case normal = "Normal"
    case poison = "Poison"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case water = "Water"
}
