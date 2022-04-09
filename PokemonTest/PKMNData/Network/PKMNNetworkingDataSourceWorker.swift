//
//  PKMNNetworkingDataSourceWorker.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNNetworkingDataSourceWorker

public class PKMNNetworkingDataSourceWorker: PKMNNetworkingDataSourceProtocol {
  // MARK: - Protocol properties

  var networking: NetworkingProtocol

  public init(networking: NetworkingProtocol) {
    self.networking = networking
  }

  public func getPokemon(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void) {
    getPokemonFromNetwork(id: id) { result in
      completion(result.map { dataSource in
        Pokemon(pokemonDataSource: dataSource)
      })
    }
  }

  private func getPokemonFromNetwork(id: String, completion: @escaping (Result<PokemonDataSource, PKMNError>) -> Void) {
    let path = "/pokemon/\(id)"
    let request = NetworkingRequest(method: .get, path: (path, nil))
    networking.send(request: request) { [weak self] result in
      self?.sendResponse(resultCompletion: result) { _result in
        completion(_result)
      }
    }
  }

  public func pokemonsList(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void) {
    getPokemonsListFromNetwork(queryItems: queryItems) { result in
      completion(result.map { dataSource in
        PokemonsList(pokemonsListDataSource: dataSource)
      })
    }
  }

  private func getPokemonsListFromNetwork(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonListDataSource, PKMNError>) -> Void) {
    let path = "/pokemon"
    let request = NetworkingRequest(method: .get, path: (path, queryItems))
    networking.send(request: request) { [weak self] result in
      self?.sendResponse(resultCompletion: result) { _result in
        completion(_result)
      }
    }
  }
}

private extension PKMNNetworkingDataSourceWorker {
  func sendResponse<SuccessResponse: Decodable>(resultCompletion: Result<SuccessResponse, Error>, completion: @escaping (Result<SuccessResponse, PKMNError>) -> Void) {
    completion(resultCompletion.mapError { error in
      guard case NetworkingError.underlying(response: let response, data: _) = error, let errorResponse = response else { return PKMNError.genericError(error.localizedDescription) }
      return PKMNErrorManager.parsePKMNError(response: errorResponse)
    })
  }
}
