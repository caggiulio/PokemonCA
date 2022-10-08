//
//  Ability.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct Ability: PKMNModel {
  let name: String

  public init(abilityDataSource: AbilityDataSource) {
    name = abilityDataSource.name
  }
}
