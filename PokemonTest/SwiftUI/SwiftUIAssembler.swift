//
//  SwiftUIAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import Foundation

/// The responsible to assemble and return the `View`s.
struct PKMNSwiftUIAssembler {
  /// The container with all UseCases.
  var container: PKMNMainContainerProtocol

  init(container: PKMNMainContainerProtocol) {
    self.container = container
  }
  
  /// Return the `PKMNSwiftUIHome`.
  func home() -> PKMNSwiftUIHome {
    PKMNSwiftUIHomeAssembler(container: container, mainAssembler: self).resolve()
  }
  
  /// Return the `PKMNSwiftUIDetail`.
  func detail(id: String) -> PKMNSwiftUIDetail {
    PKMNSwiftUIDetailAssembler(container: container, mainAssembler: self, id: id).resolve()
  }
}
