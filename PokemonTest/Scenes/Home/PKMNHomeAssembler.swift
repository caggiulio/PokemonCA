//
//  PKMNHomeAssembler.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNHomeAssembler

struct PKMNHomeAssembler: PKMNHomeAssemblerInjector {}

// MARK: - PKMNHomeAssemblerInjector

protocol PKMNHomeAssemblerInjector {
  func resolve() -> PKMNHomeViewController

  func resolve() -> PKMNHomeViewModel
}

extension PKMNHomeAssembler {
  func resolve() -> PKMNHomeViewController {
    PKMNHomeViewController(viewModel: self.resolve())
  }

  func resolve() -> PKMNHomeViewModel {
    PKMNHomeViewModel()
  }
}
