//
//  PKMNSwiftUIDetailViewModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 30/10/22.
//

import SwiftUI

class PKMNSwiftUIDetailViewModel: PKMNSwiftUIViewModel<PKMNDetailModel> {
  // MARK: - Stored Properties
  
  /// The use case to get the information about the `Pokemon` selected
  /// in the prevous step.
  @Inject private var getPokemonDetailUseCase: PKMNUseCases.GetPokemonByID
  
  /// The `id` of the `Pokemon` selected.
  private let id: String
  
  // MARK: - Init

  /// The init of the `PKMNSwiftUIDetailViewModel`.
  /// - Parameters:
  ///   - id: The `id` of the `Pokemon` selected.
  init(id: String) {
    self.id = id
  }
  
  /// The method to get the information about the `Pokemon` and returns the `PKMNDetailModel`.
  /// - Parameter id: The `String` id for the selected `Pokemon`.
  @MainActor
  func getPokemonDetails() {
    Task {
      try await processTask(function: {
        let pokemon = try await getPokemonDetailUseCase.execute(id: id)
        return PKMNDetailModel(pokemon: pokemon)
      })
    }
  }
}
