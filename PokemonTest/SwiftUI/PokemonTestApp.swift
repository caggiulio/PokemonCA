//
//  PokemonTestApp.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import Foundation

import SwiftUI

@main
struct PokemonTestApp: App {
  /// The responsible to assemble and return the `View`s.
  private let assembler = PKMNSwiftUIAssembler(container: PokemonManagerContext.container)
  
  var body: some Scene {
    WindowGroup {
      assembler.home()
    }
  }
}
