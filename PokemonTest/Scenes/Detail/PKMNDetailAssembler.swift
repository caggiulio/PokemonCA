//
//  PKMNDetailAssembler.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNDetailAssembler

struct PKMNDetailAssembler: PKMNDetailAssemblerInjector {
  var id: String

  init(id: String) {
    self.id = id
  }
}

// MARK: - PKMNDetailAssemblerInjector

protocol PKMNDetailAssemblerInjector {
  func resolve() -> PKMNDetailViewController

  func resolve() -> PKMNDetailViewModel
}

extension PKMNDetailAssembler {
  func resolve() -> PKMNDetailViewController {
    PKMNDetailViewController(viewModel: self.resolve())
  }

  func resolve() -> PKMNDetailViewModel {
    PKMNDetailViewModel(id: id)
  }
}
