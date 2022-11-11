//
//  PokemonIntentsLogic.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 07/10/22.
//

import Foundation

/// The `Logic` for the Intents and `AppIntents` framework.
struct IntentsLogic {}

extension IntentsLogic {
  /// The logic to fetch the data.
  struct FetchData {}
}

@available(iOS 16.0, *)
extension IntentsLogic.FetchData {
  /// The logic to fetch all Pokemons.
  /// This method use `withCheckedThrowingContinuation` to make all asynchronous.
  struct FetchAllPokemon {
    static func execute() async throws -> [PokemonAppEntity] {
      @Injected var getPokemonListUseCase: PKMNUseCases.GetPokemonsList

      let list = try await getPokemonListUseCase.execute(queryItems: nil)
      return list.pokemonItems.map {
        return PokemonAppEntity(id: $0.id, name: $0.name, image: $0.imageURL)
      }
    }
  }
  
  /// The logic to fetch a Pokemon by a given query.
  struct FetchPokemonByQuery {
    static func execute(query: String) async throws -> [PokemonAppEntity] {
      @Injected var searchPokemonByNameUseCase: PKMNUseCases.SearchPokemonByName
      
      let list = try await searchPokemonByNameUseCase.execute(name: query)
      return list.map {
        return PokemonAppEntity(id: $0.id, name: $0.name, image: $0.imageURL)
      }
    }
  }
}
