//
//  PKMNDetailViewModel.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNDetailViewModelProtocol

protocol PKMNDetailViewModelProtocol {
  func loadPokemon()
}

// MARK: - PKMNDetailViewModel

class PKMNDetailViewModel: PKMNViewModel<Pokemon>, PKMNDetailViewModelProtocol {
  /// The use case used to get the Pokemon by id.
  @Injected private var asyncGetPokemonByIDUseCase: PKMNUseCases.GetPokemonByID

  func loadPokemon() {
    Task {
      try await processTask(function: {
        try await asyncGetPokemonByIDUseCase.execute()
      })
    }
  }
}
