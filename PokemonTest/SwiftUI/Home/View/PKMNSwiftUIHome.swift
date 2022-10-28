//
//  Main.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

/// The `View` for the home.
public struct PKMNSwiftUIHome: View {
  // MARK: - Stored Properties
  
  /// The `PKMNSwiftUIViewModel` of the view.
  let viewModel: PKMNHomeSwiftUIViewModel
  
  // MARK: - Computed Properties
  
  /// The `PKMNModel` handeld by the `View`.
  @State private var model: PokemonsList?
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  var assembler: PKMNSwiftUIAssembler
  
  // MARK: - View
  
  public var body: some View {
    NavigationView {
      ScrollView {
        ForEach(model?.pokemonItems ?? []) { pokemon in
          #warning("Substitute it with the detail")
          NavigationLink(destination: assembler.home) {
            PKMNHomeCell(pokemon: pokemon)
          }
        }
        .padding(.all)
      }
    }
    .onAppear {
      viewModel.loadHome(queryItems: nil)
    }
    .handleLoadingState(state: viewModel.$loadingState) { model in
      self.model = model
    }
  }
}
