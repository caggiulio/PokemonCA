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
}
