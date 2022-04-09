//
//  OfficialArtworkDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct OfficialArtworkDataSource: Decodable {
    let frontDefault: String
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try values.decode(String.self, forKey: .frontDefault)
    }
}
