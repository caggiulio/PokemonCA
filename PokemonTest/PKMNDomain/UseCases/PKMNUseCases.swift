//
//  PKMNUseCases.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - Closures

/// Get real info Pokemon by his id.
public protocol GetPokemonByIDProtocol {
  func execute(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
}

/// Get real  info PokemonList.
public protocol GetPokemonsListProtocol {
  func execute(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
}

/// Get real info PokemonList by his name.
public protocol SearchPokemonByNameProtocol {
  func execute(name: String, completion: @escaping (Result<[PokemonListItem], PKMNError>) -> Void)
}

// MARK: - Mock Methods

/// Get mocked info Pokemon.
public protocol GetMockedPokemonProtocol {
  func execute(completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
}

/// Get mocked info PokemonList.
public protocol GetMockedPokemonsListProtocol {
  func execute(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
}


// MARK: - Async Methods

/// Get mocked info PokemonList.
public protocol AsyncGetPokemonByIDProtocol {
  func execute(id: String) async throws -> Pokemon
}

/// Get mocked info PokemonList.
public protocol AsyncGetPokemonsListProtocol {
  func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList
}

/// Get real info PokemonList by his name in `async` way.
public protocol AsyncSearchPokemonByNameProtocol {
  func execute(name: String) async throws -> [PokemonListItem]
}

// MARK: - Closures UseCases Implementation

enum PKMNUseCases {
  /// Get real info Pokemon by his id.
  public struct GetPokemonByID: GetPokemonByIDProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void) {
      pokemonRepository.getPokemon(id: id) { result in
        completion(result)
      }
    }
  }

  /// Get real  info PokemonList.
  public struct GetPokemonsList: GetPokemonsListProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void) {
      pokemonRepository.getPokemonsList(queryItems: queryItems) { result in
        completion(result)
      }
    }
  }

  /// Get real info PokemonList by his name.
  public struct SearchPokemonByName: SearchPokemonByNameProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    private func getCachedPokemonsByName(name: String, completion: @escaping (Result<[PokemonListItem], PKMNError>) -> Void) {
      pokemonRepository.searchCachedPokemon(name: name) { result in
        _ = result.map { pokemonsListItems in
          if pokemonsListItems.isEmpty {
            self.pokemonRepository.getPokemon(id: name) { result in
              let uniquePokemon = result.map { pokemon -> [PokemonListItem] in
                let pokemonListItem = PokemonListItem(pokemonListItemDataSource: .init(pokemon: pokemon))
                return [pokemonListItem]
              }

              completion(uniquePokemon)
            }
          } else {
            completion(.success(pokemonsListItems))
          }
        }
      }
    }

    public func execute(name: String, completion: @escaping (Result<[PokemonListItem], PKMNError>) -> Void) {
      getCachedPokemonsByName(name: name.lowercased()) { result in
        completion(result)
      }
    }
  }
  
  // MARK: - Mock Methods Implementation

  /// Get mocked info Pokemon.
  public struct GetMockedPokemon: GetMockedPokemonProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(completion: @escaping (Result<Pokemon, PKMNError>) -> Void) {
      pokemonRepository.getMockedPokemon { result in
        completion(result)
      }
    }
  }

  /// Get mocked info PokemonList .
  public struct GetMockedPokemonsList: GetMockedPokemonsListProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void) {
      pokemonRepository.getMockedPokemonsList { result in
        completion(result)
      }
    }
  }
  
  // MARK: - Async Methods Implementation
  
  /// Get real info Pokemon by his id in `async` way.
  public struct AsyncGetPokemonByID: AsyncGetPokemonByIDProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(id: String) async throws -> Pokemon {
      try await pokemonRepository.asyncGetPokemon(id: id)
    }
  }
  
  /// Get real  info PokemonList in `async` way.
  public struct AsyncGetPokemonsList: AsyncGetPokemonsListProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    public func execute(queryItems: [URLQueryItem]?) async throws -> PokemonsList {
      try await pokemonRepository.asyncGetPokemonsList(queryItems: queryItems)
    }
  }
  
  /// Get real info PokemonList by his name in `async` way.
  public struct AsyncSearchPokemonByName: AsyncSearchPokemonByNameProtocol {
    private var pokemonRepository: PKMNRepositoryProtocol

    public init(pokemonRepository: PKMNRepositoryProtocol) {
      self.pokemonRepository = pokemonRepository
    }

    private func getCachedPokemonsByName(name: String) async throws -> [PokemonListItem] {
      let pokemons = pokemonRepository.asyncSearchCachedPokemon(name: name)
      if pokemons.isEmpty {
        let pokemon = try await self.pokemonRepository.asyncGetPokemon(id: name)
        let uniquePokemon = [PokemonListItem(pokemonListItemDataSource: .init(pokemon: pokemon))]
        return uniquePokemon
      } else {
        return pokemons
      }
    }

    public func execute(name: String) async throws -> [PokemonListItem] {
      try await getCachedPokemonsByName(name: name.lowercased())
    }
  }
}
