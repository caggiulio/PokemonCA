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
  func fetchedPokemon() -> [PokemonListItem]
  func pokemon(_ forIndexPath: IndexPath) -> PokemonListItem?
  func setSelectedPokemonID(id: String)
}

// MARK: - PKMNHomeViewModel

class PKMNHomeViewModel: PKMNViewModel<Empty>, PKMNHomeViewModelProtocol {
  /// The use case used to get the Pokemon's list.
  @Injected private var asyncGetPokemonsListUseCase: PKMNUseCases.GetPokemonsList
  
  /// The use case used to search a Pokmeon by his name.
  @Injected private var asyncSearchPokemonByNameUseCase: PKMNUseCases.SearchPokemonByName
  
  /// The use case to set the selected `Pokemon` id for the next step.
  @Injected private var setSelectedPokemonUseCase: PKMNUseCases.SetSelectedPokemonID
  
  /// In this variable are stored the fetched `PokemonListItem`
  private var fetchedPokemons: [PokemonListItem] = []
  
  /// In this variable it's stored the url for the next page
  private var nextPage: String?
  
  /// `DispatchWorkItem` used to search a pokemon
  private var searchTask: Task<(), Error>?

  func loadHome(queryItems: [URLQueryItem]?) {
    loadingState = .loading(queryItems == nil)
    queryItems == nil ? fetchedPokemons.removeAll() : nil
    
    Task {
      try await process {
        let pokemonList = try await asyncGetPokemonsListUseCase.execute(queryItems: queryItems)
        self.nextPage = pokemonList.next
        let pokemonItems = pokemonList.pokemonItems
        self.fetchedPokemons.append(contentsOf: pokemonItems)
        
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

  func fetchedPokemon() -> [PokemonListItem] {
    return fetchedPokemons
  }

  func pokemon(_ indexPath: IndexPath) -> PokemonListItem? {
    return fetchedPokemons[indexPath.item]
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
      try await process {
        try await Task.sleep(nanoseconds: 500_000_000)
        let pokemons = try await self.asyncSearchPokemonByNameUseCase.execute(name: name)
        self.fetchedPokemons = pokemons
        
        return Empty()
      }
    }
    searchTask = task
  }
  
  func setSelectedPokemonID(id: String) {
    setSelectedPokemonUseCase.execute(id: id)
  }
}
