//
//  JSONDataSourceWorker.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The concrete implementation of `JSONDataSourceProtocol` in order to made mock calls.
struct JSONDataSourceWorker: JSONDataSourceProtocol, Injectable {
  /// Make a mock `Pokemon` single call.
  func getPokemon() async throws -> Pokemon {
    let decoder = JSONDecoder()
    let fileName = JSONFilesNames.singlePokemon

    guard let url = PKMNConstants.mainBundle().url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url), let dataSource = try? decoder.decode(PokemonDataSource.self, from: data)
    else {
      throw PKMNError.genericError(PKMNString.standardError)
    }

    let pokemon = Pokemon(pokemonDataSource: dataSource)
    return pokemon
  }

  /// Make a mock `PokemonsList` list call.
  func pokemonsList() async throws -> PokemonsList {
    let decoder = JSONDecoder()
    let fileName = JSONFilesNames.pokemonsList

    guard let url = PKMNConstants.mainBundle().url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url), let dataSource = try? decoder.decode(PokemonListDataSource.self, from: data)
    else {
      throw PKMNError.genericError(PKMNString.standardError)
    }

    let pokemonsList = PokemonsList(pokemonsListDataSource: dataSource)
    return pokemonsList
  }
}
