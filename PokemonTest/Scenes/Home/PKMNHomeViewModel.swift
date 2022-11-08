//
//  PKMNViewModel.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNHomeViewModelProtocol

protocol PKMNHomeViewModelProtocol {
  func loadHome(queryItems: [URLQueryItem]?)
  func searchPokemon(name: String)
  func getNextPage()
  func retrievedPokemon() -> [PokemonListItem]
  func pokemon(_ forIndexPath: IndexPath) -> PokemonListItem?
}

// MARK: - PKMNHomeViewModel

class PKMNHomeViewModel: PKMNViewModel<Empty>, PKMNHomeViewModelProtocol {
  /// The use case used to get the Pokemon's list.
  @Inject private var asyncGetPokemonsListUseCase: PKMNUseCases.GetPokemonsList
  
  /// The use case used to search a Pokmeon by his name.
  @Inject private var asyncSearchPokemonByNameUseCase: PKMNUseCases.SearchPokemonByName
  
  /// In this variable are stored the retrieved `PokemonListItem`
  private var retrievedPokemons: [PokemonListItem] = []
  
  /// In this variable it's stored the url for the next page
  private var nextPage: String?
  
  /// `DispatchWorkItem` used to search a pokemon
  private var searchTask: Task<(), Error>?

  func loadHome(queryItems: [URLQueryItem]?) {
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

  func getNextPage() {
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

  func retrievedPokemon() -> [PokemonListItem] {
    return retrievedPokemons
  }

  func pokemon(_ indexPath: IndexPath) -> PokemonListItem? {
    return retrievedPokemons[indexPath.item]
  }

  func searchPokemon(name: String) {
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
