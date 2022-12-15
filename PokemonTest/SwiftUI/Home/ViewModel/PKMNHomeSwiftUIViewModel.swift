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
  @Injected private var getPokemonsListUseCase: PKMNUseCases.GetPokemonsList
  
  /// The use case used to search a Pokemon by a string.
  @Injected private var searchPokemonByNameUseCase: PKMNUseCases.SearchPokemonByName
  
  /// The use case to set the selected `Pokemon` id for the next step.
  @Injected private var setSelectedPokemonUseCase: PKMNUseCases.SetSelectedPokemonID
  
  /// The use case to get the current weather for the current location.
  @Injected private var getCurrentWeatherUseCase: PKMNUseCases.GetCurrentWeather
  
  // MARK: - Computed Properties
  
  /// In this variable it's stored the url for the next page.
  private var nextPage: String?
  
  /// In this variable are stored the fetched `PokemonListItem`.
  private var fetchedPokemons: [PokemonListItem] = []
  
  /// The method to trigger the `getPokemonsListUseCase`.
  /// - Parameter queryItems: the array of the `URLQueryItem` to pass to the API.
  @MainActor
  func loadHome(queryItems: [URLQueryItem]?) {
    queryItems == nil ? fetchedPokemons.removeAll() : nil
    loadingState = .loading(true)
    
    Task {
      try await process {
        let list = try await self.getPokemonsListUseCase.execute(queryItems: queryItems)
        nextPage = list.next
        fetchedPokemons.append(contentsOf: list.pokemonItems)
        return PKMNHomeModel(pokemonList: fetchedPokemons, filteredPokemonList: [], currentWeather: lastValueModel?.currentWeather)
      }
    }
    
    if #available(iOS 16.0, *) {
      getWeatherInformation()
    }
  }
  
  /// The method to trigger the `getPokemonsListUseCase`.
  /// - Parameter name: the `String` to filter the list.
  @MainActor
  func searchByName(name: String) {
    guard !name.isEmpty else {
      loadHome(queryItems: nil)
      return
    }
    
    Task {
      try await process {
        let filteredList = try await self.searchPokemonByNameUseCase.execute(name: name)
        nextPage = nil
        return PKMNHomeModel(pokemonList: [], filteredPokemonList: filteredList, currentWeather: lastValueModel?.currentWeather)
      }
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
  
  /// The method to trigger the `setSelectedPokemonUseCase`.
  /// - Parameter id: the `String` id of the selected `Pokemon`.
  @MainActor
  func setSelectedPokemon(id: String) {
    setSelectedPokemonUseCase.execute(id: id)
    activeLink = .detail
  }
}

private extension PKMNHomeSwiftUIViewModel {
  /// Get the current weather information and update the model.
  /// After 5 seconds, the state will change to hide the current weather view.
  /// This method is available only for iOS 16.0 and next.
  @MainActor
  private func getWeatherInformation() {
    Task {
      do {
        let currentWeather = try await getCurrentWeatherUseCase.execute()
        self.loadingState = .success(PKMNHomeModel(pokemonList: fetchedPokemons, filteredPokemonList: [], currentWeather: currentWeather))
        
        try await Task.sleep(for: .seconds(5))
        self.loadingState = .success(PKMNHomeModel(pokemonList: fetchedPokemons, filteredPokemonList: [], currentWeather: nil))
      } catch {}
    }
  }
}
