//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//
import Foundation

public struct PokemonListDataSource: Decodable {
	let count: Int
	let next: String
	let results: [PokemonListItemDataSource]

	private enum CodingKeys: String, CodingKey {
		case count = "count"
		case next = "next"
		case previous = "previous"
		case results = "results"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		count = try values.decode(Int.self, forKey: .count)
		next = try values.decode(String.self, forKey: .next)
		results = try values.decode([PokemonListItemDataSource].self, forKey: .results)
	}

}
