//
//  SwiftUIHomeAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import Foundation

// MARK: - PKMNHomeAssembler

public struct PKMNSwiftUIHomeAssembler: PKMNSwiftUIHomeAssemblerInjector {
  var container: PKMNMainContainerProtocol
  var mainAssembler: PKMNSwiftUIAssembler

  public init(container: PKMNMainContainerProtocol, mainAssembler: PKMNSwiftUIAssembler) {
    self.container = container
    self.mainAssembler = mainAssembler
  }
}

// MARK: - PKMNHomeAssemblerInjector

public protocol PKMNSwiftUIHomeAssemblerInjector {
  func resolve() -> PKMNSwiftUIHome

  func resolve() -> PKMNHomeSwiftUIViewModel
}

public extension PKMNSwiftUIHomeAssembler {
  func resolve() -> PKMNSwiftUIHome {
    return PKMNSwiftUIHome(viewModel: self.resolve(), assembler: mainAssembler)
  }

  func resolve() -> PKMNHomeSwiftUIViewModel {
    return PKMNHomeSwiftUIViewModel(asyncGetPokemonsListUseCase: container.asyncGetPokemonsListUseCase)
  }
}

