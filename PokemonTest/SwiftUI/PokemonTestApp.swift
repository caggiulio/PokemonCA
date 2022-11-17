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
  /// The `DependencyManager` that adds the dependencies in the init.
  private let manager = DependencyManager()
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  @Injected var assembler: PKMNSwiftUIAssembler
  
  var body: some Scene {
    WindowGroup {
      assembler.home()
    }
  }
}
