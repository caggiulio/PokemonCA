//
//  StatsDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct StatsDataSource: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: StatDataSource
    
    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort = "effort"
        case stat = "stat"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try values.decode(Int.self, forKey: .baseStat)
        effort = try values.decode(Int.self, forKey: .effort)
        stat = try values.decode(StatDataSource.self, forKey: .stat)
    }
}
