//
//  PKMNHomeModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 29/10/22.
//

import SwiftUI

/// This is the model used to fill the home.
struct PKMNHomeModel: PKMNModel {
  // MARK: - Stored Properties
  
  /// The title of the view.
  let title = PKMNString.homeTitle
  
  /// The list of Pokemon to show.
  let pokemonList: [PokemonListItem]
  
  /// The filtered list of Pokemon to show.
  let filteredPokemonList: [PokemonListItem]
  
  /// The current weather  information.
  let currentWeather: CurrentWeather?
  
  // MARK: - Computed Properties
  
  /// Wheter the list is filtered or not.
  var isFiltered: Bool {
    !filteredPokemonList.isEmpty
  }
  
  /// The model for the `PKMNSwiftUIHomeBody`.
  var bodyModel: PKMNHomeBodyModel {
    PKMNHomeBodyModel(
      title: title,
      isFiltered: isFiltered,
      pokemonList: pokemonList,
      filteredPokemonList: filteredPokemonList
    )
  }
  
  /// The title for the `PKMNHomeWeatherModel`.
  var weatherTitle: String {
    guard let currentWeather = currentWeather else {
      return String()
    }
    
    return PKMNString.weatherTitle(String(format: "%.f", currentWeather.temperature), currentWeather.condition)
  }
  
  /// Wheter the `PKMNHomeWeatherInformation` is visible or not.
  var isWeatherInformationVisible: Bool {
    currentWeather != nil
  }
  
  /// The model for the `PKMNWeatherInformation` `View`.
  var weatherModel: PKMNHomeWeatherModel {
    PKMNHomeWeatherModel(
      title: weatherTitle,
      icon: Image(systemName: currentWeather?.symbolName ?? String())
    )
  }
}
