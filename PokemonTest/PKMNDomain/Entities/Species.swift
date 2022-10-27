//
//  Species.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct Species: PKMNModel {
  let name: String

  public init(speciesDataSource: SpeciesDataSource) {
    name = speciesDataSource.name
  }
}
