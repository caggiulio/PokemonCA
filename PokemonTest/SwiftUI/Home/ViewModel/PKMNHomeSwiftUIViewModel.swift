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
  
  // MARK: - Computed Properties
  
  /// In this variable it's stored the url for the next page.
  private var nextPage: String?
  
  /// In this variable are stored the retrieved `PokemonListItem`
  private var retrievedPokemons: [PokemonListItem] = []
    
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
    queryItems == nil ? retrievedPokemons.removeAll() : nil
    loadingState = .loading(true)
    
    Task {
      try await processTask(function: {
        let list = try await getPokemonsListUseCase.execute(queryItems: queryItems)
        nextPage = list.next
        retrievedPokemons.append(contentsOf: list.pokemonItems)
        return PKMNHomeModel(pokemonList: retrievedPokemons, filteredPokemonList: [])
      })
    }
  }
  
  /// The method to trigger the `getPokemonsListUseCase`.
  /// - Parameter name: the `String` to filter the list.
  @MainActor
  func searchByName(name: String) {
    loadingState = .loading(true)
    
    guard !name.isEmpty else {
      loadHome(queryItems: nil)
      return
    }
    
    Task {
      try await processTask(function: {        
        let list = try await self.searchPokemonByNameUseCase.execute(name: name)
        nextPage = nil
        return PKMNHomeModel(pokemonList: retrievedPokemons, filteredPokemonList: list)
      })
    }
  }
  
  /// This is the func to load the next page and update the list.
  @MainActor
  func getNextPage() {
    guard
      let next = nextPage,
      let nextUrl = URL(string: next),
      let urlComponents = URLComponents(url: nextUrl, resolvingAgainstBaseURL: false),
      let queryItems = urlComponents.queryItems
    else { return }

    loadHome(queryItems: queryItems)
  }
}
