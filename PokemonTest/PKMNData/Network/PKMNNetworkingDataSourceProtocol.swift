//
//  PKMNNetworkingDataSourceProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public protocol PKMNNetworkingDataSourceProtocol {
    func getPokemon(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
    func pokemonsList(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
}
