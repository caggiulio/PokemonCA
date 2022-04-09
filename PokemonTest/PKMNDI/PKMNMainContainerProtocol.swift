//
//  PKMNMainContainerProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public protocol PKMNMainContainerProtocol {
    /// Get real info Pokemon by his id
    var getPokemonByIDUseCase: GetPokemonByIDProtocol { get }
    /// Get real  info PokemonList
    var getPokemonsListUseCase: GetPokemonsListProtocol { get }
    /// Get real info PokemonList by his name
    var searchPokemonByNameUseCase: SearchPokemonByNameProtocol { get }
    /// Get mocked info Pokemon
    var getMockedPokemonUseCase: GetMockedPokemonProtocol { get }
    /// Get mocked info PokemonList
    var getMockedPokemonsListUseCase: GetMockedPokemonsListProtocol { get }
}
