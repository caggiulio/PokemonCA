//
//  PKMNDetailViewModel.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNDetailViewModelProtocol

public protocol PKMNDetailViewModelProtocol {
  func loadPokemon()
}

// MARK: - PKMNDetailViewModel

public class PKMNDetailViewModel: PKMNViewModel<Pokemon>, PKMNDetailViewModelProtocol {
  /// Use cases
  private let asyncGetPokemonByIDUseCase: AsyncGetPokemonByIDProtocol
  /// In this variable it's stored the currentPokemon `id`
  private var id: String

  public init(asyncGetPokemonByIDUseCase: AsyncGetPokemonByIDProtocol, id: String) {
    self.asyncGetPokemonByIDUseCase = asyncGetPokemonByIDUseCase
    self.id = id
  }

  public func loadPokemon() {
    Task {
      try await processTask(function: {
        try await asyncGetPokemonByIDUseCase.execute(id: id)
      })
    }
  }
}
