//
//  PKMNNetworkingDataSourceWorker.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import AloyNetworking

// MARK: - PKMNNetworkingDataSourceWorker

class PKMNNetworkingDataSourceWorker: PKMNNetworkingDataSourceProtocol {
  
  // MARK: - Protocol properties

  var networking: AloyNetworkingProtocol

  // MARK: - Init
  
  /// The `init` with a `AloyNetworkingProtocol`.
  /// - Parameter networking: The `AloyNetworkingProtocol`.
  init(networking: AloyNetworkingProtocol) {
    self.networking = networking
  }
  
  // MARK: - Async methods
  
  /// Get and transform the `PokemonDataSource` retrieved from the network in the `Pokemon` return object.
  func getPokemon(id: String) async throws -> Pokemon {
    let response = try await sendResponse {
      try await getPokemonDataSource(id: id)
    }
    return Pokemon(pokemonDataSource: response)
  }
  
  private func getPokemonDataSource(id: String) async throws -> PokemonDataSource {
    let path = "/pokemon/\(id)"
    let request = AloyNetworkingRequest(method: .get, path: (path, nil))
    return try await networking.send(request: request)
  }
  
  /// Get and transform the `PokemonListDataSource` retrieved from the network in the `PokemonsList` return object.
  func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
    let response = try await sendResponse {
      try await asyncGetPokemonsListDataSource(queryItems: queryItems)
    }
    return PokemonsList(pokemonsListDataSource: response)
  }
  
  private func asyncGetPokemonsListDataSource(queryItems: [URLQueryItem]?) async throws -> PokemonListDataSource {
    let path = "/pokemon"
    let request = AloyNetworkingRequest(method: .get, path: (path, queryItems))
    return try await networking.send(request: request)
  }
}

private extension PKMNNetworkingDataSourceWorker {
  /// Transform the `Error` in the `PKMNError`.
  func sendResponse<SuccessResponse: Decodable>(function: () async throws -> SuccessResponse) async rethrows -> SuccessResponse {
    do {
      return try await function()
    } catch let error {
      guard case AloyNetworkingError.underlying(response: let response, data: _) = error, let errorResponse = response else { throw PKMNError.genericError(error.localizedDescription) }
      throw PKMNErrorManager.parsePKMNError(response: errorResponse)
    }
  }
}
