//
//  Stat.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct Stat {
  let name: String
  let baseStat: Int
  let percentStat: Float

  public init(statDataSource: StatsDataSource) {
    name = statDataSource.stat.name
    baseStat = statDataSource.baseStat
    percentStat = Float(baseStat) / 100
  }
}
