//
//  Assembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 09/11/22.
//

import Foundation

/// The responsible to assemble and return the `ViewController`s.
struct PKMNAssembler {
  /// Return the `PKMNHomeViewController`.
  func home() -> PKMNHomeViewController {
    PKMNHomeViewController(viewModel: PKMNHomeViewModel())
  }
  
  /// Return the `PKMNDetailViewController`.
  func detail() -> PKMNDetailViewController {
    PKMNDetailViewController(viewModel: PKMNDetailViewModel())
  }
}

