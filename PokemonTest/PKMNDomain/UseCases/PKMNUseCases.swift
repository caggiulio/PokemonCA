//
//  PKMNUseCases.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - GetPokemonByIDProtocol

public protocol GetPokemonByIDProtocol {
  func execute(id: String, completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
}

// MARK: - GetPokemonsListProtocol

public protocol GetPokemonsListProtocol {
  func execute(queryItems: [URLQueryItem]?, completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
}

// MARK: - SearchPokemonByNameProtocol

public protocol SearchPokemonByNameProtocol {
  func execute(name: String, completion: @escaping (Result<[PokemonListItem], PKMNError>) -> Void)
}

// MARK: - GetMockedPokemonProtocol

public protocol GetMockedPokemonProtocol {
  func execute(completion: @escaping (Result<Pokemon, PKMNError>) -> Void)
}

// MARK: - GetMockedPokemonsListProtocol

public protocol GetMockedPokemonsListProtocol {
  func execute(completion: @escaping (Result<PokemonsList, PKMNError>) -> Void)
}

// MARK: - PKMNUseCases

enum PKMNUseCases {
  public class GetPokemonByID: GetPokemonByIDProtocol {
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

  public class GetPokemonsList: GetPokemonsListProtocol {
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

  public class SearchPokemonByName: SearchPokemonByNameProtocol {
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

  public class GetMockedPokemon: GetMockedPokemonProtocol {
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

  public class GetMockedPokemonsList: GetMockedPokemonsListProtocol {
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
}
