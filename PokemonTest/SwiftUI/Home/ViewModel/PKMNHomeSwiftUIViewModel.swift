//
//  PKMNHomeSwiftUIViewModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

class PKMNHomeSwiftUIViewModel: PKMNSwiftUIViewModel<PKMNHomeModel> {
  // MARK: - Stored Properties
  
  /// The use case used to get the Pokemon's list.
  private let getPokemonsListUseCase: AsyncGetPokemonsListProtocol
  
  /// The use case used to search a Pokemon by a string.
  private let searchPokemonByNameUseCase: AsyncSearchPokemonByNameProtocol
    
  // MARK: - Init

  /// The init of the `PKMNSwiftUIViewModel`.
  /// - Parameters
  ///   - getPokemonsListUseCase: The use case to fetch the data list.
  ///   - searchPokemonByNameUseCase: The use case used to search a Pokemon by a string.
  init(getPokemonsListUseCase: AsyncGetPokemonsListProtocol, searchPokemonByNameUseCase: AsyncSearchPokemonByNameProtocol) {
    self.getPokemonsListUseCase = getPokemonsListUseCase
    self.searchPokemonByNameUseCase = searchPokemonByNameUseCase
  }

  /// The method to trigger the `getPokemonsListUseCase`.
  /// - Parameter queryItems: the array of the `URLQueryItem` to pass to the API.
  @MainActor
  func loadHome(queryItems: [URLQueryItem]?) {
    loadingState = .loading(true)
    
    Task {
      try await processTask(function: {
        let list = try await getPokemonsListUseCase.execute(queryItems: queryItems)
        return PKMNHomeModel(pokemonList: list.pokemonItems)
      })
    }
  }
  
  /// The method to trigger the `getPokemonsListUseCase`.
  /// - Parameter name: the `String` to filter the list.
  func searchByName(name: String) {
    loadingState = .loading(true)
    
    Task {
      try await processTask(function: {
        guard !name.isEmpty else {
          let list = try await getPokemonsListUseCase.execute(queryItems: nil)
          return PKMNHomeModel(pokemonList: list.pokemonItems)
        }
        
        let list = try await self.searchPokemonByNameUseCase.execute(name: name)
        return PKMNHomeModel(pokemonList: list)
      })
    }
  }
}
