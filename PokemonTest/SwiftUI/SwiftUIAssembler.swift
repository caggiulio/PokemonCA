//
//  SwiftUIAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import Foundation

/// The responsible to assemble and return the `View`s.
struct PKMNSwiftUIAssembler: Injectable {
  /// Return the `PKMNSwiftUIHome`.
  func home() -> PKMNSwiftUIHome {
    PKMNSwiftUIHomeAssembler().resolve()
  }
  
  /// Return the `PKMNSwiftUIDetail`.
  func detail(id: String) -> PKMNSwiftUIDetail {
    PKMNSwiftUIDetailAssembler(id: id).resolve()
  }
}
