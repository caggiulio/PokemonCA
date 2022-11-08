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
  @Inject private var asyncGetPokemonByIDUseCase: PKMNUseCases.GetPokemonByID
  
  /// In this variable it's stored the currentPokemon `id`.
  private var id: String

  init(id: String) {
    self.id = id
  }

  func loadPokemon() {
    Task {
      try await processTask(function: {
        try await asyncGetPokemonByIDUseCase.execute(id: id)
      })
    }
  }
}
