//
//  SwiftUIAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import Foundation

/// The responsible to assemble and return the `View`s.
public struct PKMNSwiftUIAssembler {
  /// The container with all UseCases.
  var container: PKMNMainContainerProtocol

  public init(container: PKMNMainContainerProtocol) {
    self.container = container
  }
  
  /// Return the `PKMNSwiftUIHome`.
  public func home() -> PKMNSwiftUIHome {
    PKMNSwiftUIHomeAssembler(container: container, mainAssembler: self).resolve()
  }
}
