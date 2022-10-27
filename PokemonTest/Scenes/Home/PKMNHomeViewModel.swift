//
//  PKMNViewModel.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNHomeViewModelProtocol

public protocol PKMNHomeViewModelProtocol {
  func loadHome(queryItems: [URLQueryItem]?)
  func searchPokemon(name: String)
  func getNextPage()
  func retrievedPokemon() -> [PokemonListItem]
  func pokemon(_ forIndexPath: IndexPath) -> PokemonListItem?
}

// MARK: - PKMNHomeViewModel

public class PKMNHomeViewModel: PKMNViewModel<Empty>, PKMNHomeViewModelProtocol {
  /// The use case used to get the Pokemon's list.
  private let asyncGetPokemonsListUseCase: AsyncGetPokemonsListProtocol
  
  /// The use case used to search a Pokmeon by his name.
  private let asyncSearchPokemonByNameUseCase: AsyncSearchPokemonByNameProtocol
  
  /// In this variable are stored the retrieved `PokemonListItem`
  private var retrievedPokemons: [PokemonListItem] = []
  
  /// In this variable it's stored the url for the next page
  private var nextPage: String?
  
  /// `DispatchWorkItem` used to search a pokemon
  private var searchTask: Task<(), Error>?

  public init(asyncGetPokemonsListUseCase: AsyncGetPokemonsListProtocol, asyncSearchPokemonByNameUseCase: AsyncSearchPokemonByNameProtocol) {
    self.asyncGetPokemonsListUseCase = asyncGetPokemonsListUseCase
    self.asyncSearchPokemonByNameUseCase = asyncSearchPokemonByNameUseCase
  }

  public func loadHome(queryItems: [URLQueryItem]?) {
    loadingState = .loading(queryItems == nil)
    queryItems == nil ? retrievedPokemons.removeAll() : nil
    
    Task {
      try await processTask {
        let pokemonList = try await asyncGetPokemonsListUseCase.execute(queryItems: queryItems)
        self.nextPage = pokemonList.next
        let pokemonItems = pokemonList.pokemonItems
        self.retrievedPokemons.append(contentsOf: pokemonItems)
        
        return Empty()
      }
    }
  }

  public func getNextPage() {
    /// If `searchTask != nil` a search is in progress.
    guard searchTask == nil else { return }
    guard
      let next = nextPage,
      let nextUrl = URL(string: next),
      let urlComponents = URLComponents(url: nextUrl, resolvingAgainstBaseURL: false),
      let queryItems = urlComponents.queryItems
    else { return }

    loadHome(queryItems: queryItems)
  }

  public func retrievedPokemon() -> [PokemonListItem] {
    return retrievedPokemons
  }

  public func pokemon(_ indexPath: IndexPath) -> PokemonListItem? {
    return retrievedPokemons[indexPath.item]
  }

  public func searchPokemon(name: String) {
    searchTask?.cancel()
    searchTask = nil
    /// If text is empty, we must to reload the lists
    guard !name.isEmpty else {
      loadHome(queryItems: nil)
      return
    }

    let task = Task {
      try await processTask {
        try await Task.sleep(nanoseconds: 500_000_000)
        let pokemons = try await self.asyncSearchPokemonByNameUseCase.execute(name: name)
        self.retrievedPokemons = pokemons
        
        return Empty()
      }
    }
    searchTask = task
  }
}
