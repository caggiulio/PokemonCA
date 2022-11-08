//
//  SwiftUIHomeAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import Foundation

// MARK: - PKMNHomeAssembler

struct PKMNSwiftUIHomeAssembler: PKMNSwiftUIHomeAssemblerInjector {
  @Inject private var mainAssembler: PKMNSwiftUIAssembler
}

// MARK: - PKMNHomeAssemblerInjector

protocol PKMNSwiftUIHomeAssemblerInjector {
  func resolve() -> PKMNSwiftUIHome

  func resolve() -> PKMNHomeSwiftUIViewModel
}

extension PKMNSwiftUIHomeAssembler {
  func resolve() -> PKMNSwiftUIHome {
    PKMNSwiftUIHome(viewModel: self.resolve())
  }

  func resolve() -> PKMNHomeSwiftUIViewModel {
    PKMNHomeSwiftUIViewModel()
  }
}

