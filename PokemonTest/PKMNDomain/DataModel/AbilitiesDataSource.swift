//
//  AbilitiesDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct AbilitiesDataSource: Decodable {    
    let ability: AbilityDataSource
    let isHidden: Bool
    let slot: Int
    
    private enum CodingKeys: String, CodingKey {
        case ability = "ability"
        case isHidden = "is_hidden"
        case slot = "slot"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ability = try values.decode(AbilityDataSource.self, forKey: .ability)
        isHidden = try values.decode(Bool.self, forKey: .isHidden)
        slot = try values.decode(Int.self, forKey: .slot)
    }
}

