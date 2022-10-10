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
  /// Use case
  private let getPokemonByIDUseCase: GetPokemonByIDProtocol
  /// In this variable it's stored the currentPokemon `id`
  private var id: String

  public init(getPokemonByIDUseCase: GetPokemonByIDProtocol, id: String) {
    self.getPokemonByIDUseCase = getPokemonByIDUseCase
    self.id = id
  }

  public func loadPokemon() {
    loadingState = .loading(true)

    getPokemonByIDUseCase.execute(id: id) { [weak self] result in
      switch result {
        case let .success(pokemon):
        DispatchQueue.main.async {
          self?.loadingState = .success(pokemon)
        }
        case let .failure(error):
          self?.loadingState = .failure(error)
      }
    }
  }
}
