//
//  PKMNMainContainerProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public protocol PKMNMainContainerProtocol {
  // MARK: - Mock Methods
  
  /// Get mocked info Pokemon.
  var getMockedPokemonUseCase: GetMockedPokemonProtocol { get }
  
  /// Get mocked info PokemonList.
  var getMockedPokemonsListUseCase: GetMockedPokemonsListProtocol { get }
  
  // MARK: - Async
  
  /// Get real info Pokemon by his id in `async` way.
  var asyncGetPokemonByIDUseCase: AsyncGetPokemonByIDProtocol { get }
  
  /// Get real  info PokemonList in `async` way.
  var asyncGetPokemonsListUseCase: AsyncGetPokemonsListProtocol { get }
  
  /// Get real info PokemonList by his name in `async` way.
  var asyncSearchPokemonByNameUseCase: AsyncSearchPokemonByNameProtocol { get }
}
