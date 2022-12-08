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
  @Injected private var getPokemonDetailUseCase: PKMNUseCases.GetPokemonByID
  
  /// The use case used to get the Pokemon overall.
  @Injected private var getPokemonOverallUseCase: PKMNUseCases.GetPokemonOverall
  
  /// The method to get the information about the `Pokemon` and returns the `PKMNDetailModel`.
  /// - Parameter id: The `String` id for the selected `Pokemon`.
  @MainActor
  func getPokemonDetails() {
    Task {
      try await process {
        let pokemon = try await getPokemonDetailUseCase.execute()
        let pokemonOverall = try await getPokemonOverallUseCase.execute()
        return PKMNDetailModel(pokemon: pokemon, overallModel: OverallModel(title: PKMNString.overall, value: pokemonOverall))
      }
    }
  }
}
