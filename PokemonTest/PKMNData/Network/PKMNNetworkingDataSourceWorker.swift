//
//  PKMNNetworkingDataSourceWorker.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import AloyNetworking

// MARK: - PKMNNetworkingDataSourceWorker

public class PKMNNetworkingDataSourceWorker: PKMNNetworkingDataSourceProtocol {
  
  // MARK: - Protocol properties

  var networking: AloyNetworkingProtocol

  // MARK: - Init
  
  /// The `init` with a `AloyNetworkingProtocol`.
  /// - Parameter networking: The `AloyNetworkingProtocol`.
  public init(networking: AloyNetworkingProtocol) {
    self.networking = networking
  }

  // MARK: - Closure method
  
  /// Get and transform the `PokemonDataSource` retrieved from the network in the `Pokemon` return object.
  public func getPokemon(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void) {
    getPokemonFromNetwork(id: id) { result in
      completion(result.map { dataSource in
        Pokemon(pokemonDataSource: dataSource)
      })
    }
  }

  private func getPokemonFromNetwork(id: String, completion: @escaping (Result<PokemonDataSource, PKMNError>) -> Void) {
    let path = "/pokemon/\(id)"
    let request = AloyNetworkingRequest(method: .get, path: (path, nil))
    networking.send(request: request) { [weak self] result in
      self?.sendResponse(resultCompletion: result) { _result in
        completion(_result)
      }
    }
  }

  /// Get and transform the `PokemonListDataSource` retrieved from the network in the `PokemonsList` return object.
  public func pokemonsList(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void) {
    getPokemonsListFromNetwork(queryItems: queryItems) { result in
      completion(result.map { dataSource in
        PokemonsList(pokemonsListDataSource: dataSource)
      })
    }
  }

  private func getPokemonsListFromNetwork(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonListDataSource, PKMNError>) -> Void) {
    let path = "/pokemon"
    let request = AloyNetworkingRequest(method: .get, path: (path, queryItems))
    networking.send(request: request) { [weak self] result in
      self?.sendResponse(resultCompletion: result) { _result in
        completion(_result)
      }
    }
  }
  
  // MARK: - Async methods
  
  /// Get and transform the `PokemonDataSource` retrieved from the network in the `Pokemon` return object.
  public func getPokemon(id: String) async throws -> Pokemon {
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
  public func asyncGetPokemonsList(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
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
  func sendResponse<SuccessResponse: Decodable>(resultCompletion: Result<SuccessResponse, Error>, completion: @escaping (Result<SuccessResponse, PKMNError>) -> Void) {
    completion(resultCompletion.mapError { error in
      guard case AloyNetworkingError.underlying(response: let response, data: _) = error, let errorResponse = response else { return PKMNError.genericError(error.localizedDescription) }
      return PKMNErrorManager.parsePKMNError(response: errorResponse)
    })
  }
  
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
