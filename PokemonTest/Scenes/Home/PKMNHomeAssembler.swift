//
//  PKMNHomeAssembler.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNHomeAssembler

public class PKMNHomeAssembler: PKMNHomeAssemblerInjector {
  var container: PKMNMainContainerProtocol

  public init(container: PKMNMainContainerProtocol) {
    self.container = container
  }
}

// MARK: - PKMNHomeAssemblerInjector

public protocol PKMNHomeAssemblerInjector {
  func resolve() -> PKMNHomeViewController

  func resolve() -> PKMNHomeViewModel
}

public extension PKMNHomeAssembler {
  func resolve() -> PKMNHomeViewController {
    return PKMNHomeViewController(viewModel: self.resolve())
  }

  func resolve() -> PKMNHomeViewModel {
    return PKMNHomeViewModel(getPokemonsListUseCase: container.getPokemonsListUseCase, searchPokemonByNameUseCase: container.searchPokemonByNameUseCase)
  }
}
