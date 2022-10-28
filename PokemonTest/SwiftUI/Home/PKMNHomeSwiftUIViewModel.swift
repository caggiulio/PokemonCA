//
//  PKMNHomeSwiftUIViewModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import Foundation

public class PKMNHomeSwiftUIViewModel: PKMNSwiftUIViewModel<PokemonsList> {
  /// The use case used to get the Pokemon's list.
  private let asyncGetPokemonsListUseCase: AsyncGetPokemonsListProtocol

  public init(asyncGetPokemonsListUseCase: AsyncGetPokemonsListProtocol) {
    self.asyncGetPokemonsListUseCase = asyncGetPokemonsListUseCase
  }

  @MainActor
  public func loadHome(queryItems: [URLQueryItem]?) {
    loadingState = .loading(true)
    
    Task {
      try await processTask(function: {
        try await asyncGetPokemonsListUseCase.execute(queryItems: queryItems)
      })
    }
  }
}
