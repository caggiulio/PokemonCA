//
//  PKMNUseCasesProtocol.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 21/10/22.
//

import Foundation

// MARK: - Mock Methods

/// Get mocked info Pokemon.
protocol GetMockedPokemonProtocol: Injectable {
  func execute() async throws -> Pokemon
}

/// Get mocked info PokemonList.
protocol GetMockedPokemonsListProtocol: Injectable {
  func execute() async throws -> PokemonsList
}


// MARK: -  Methods

/// Get mocked info PokemonList.
protocol GetPokemonByIDProtocol: Injectable {
  func execute() async throws -> Pokemon
}

/// Get mocked info PokemonList.
protocol GetPokemonsListProtocol: Injectable {
  func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}

/// Get real info PokemonList by his name in `async` way.
protocol SearchPokemonByNameProtocol: Injectable {
  func execute(name: String) async throws -> [PokemonListItem]
}

/// Set the id for a selected `Pokemon`.
protocol SetSelectedPokemonIDProtocol: Injectable {
  func execute(id: String)
}

/// Get the id for a selected `Pokemon`.
protocol GetSelectedPokemonIDProtocol: Injectable {
  func execute() -> String
}

/// Get the overall for a selected `Pokemon`.
protocol GetOverallProtocol: Injectable {
  func execute() async throws -> Float
}

/// Get the current weather information for the current location.
protocol GetCurrentWeatherProtocol: Injectable {
  func execute() async throws -> CurrentWeather
}
