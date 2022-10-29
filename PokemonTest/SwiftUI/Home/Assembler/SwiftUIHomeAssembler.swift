//
//  SwiftUIHomeAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import Foundation

// MARK: - PKMNHomeAssembler

struct PKMNSwiftUIHomeAssembler: PKMNSwiftUIHomeAssemblerInjector {
  var container: PKMNMainContainerProtocol
  var mainAssembler: PKMNSwiftUIAssembler

  init(container: PKMNMainContainerProtocol, mainAssembler: PKMNSwiftUIAssembler) {
    self.container = container
    self.mainAssembler = mainAssembler
  }
}

// MARK: - PKMNHomeAssemblerInjector

protocol PKMNSwiftUIHomeAssemblerInjector {
  func resolve() -> PKMNSwiftUIHome

  func resolve() -> PKMNHomeSwiftUIViewModel
}

extension PKMNSwiftUIHomeAssembler {
  func resolve() -> PKMNSwiftUIHome {
    PKMNSwiftUIHome(viewModel: self.resolve(), assembler: mainAssembler)
  }

  func resolve() -> PKMNHomeSwiftUIViewModel {
    PKMNHomeSwiftUIViewModel(getPokemonsListUseCase: container.asyncGetPokemonsListUseCase, searchPokemonByNameUseCase: container.asyncSearchPokemonByNameUseCase)
  }
}

