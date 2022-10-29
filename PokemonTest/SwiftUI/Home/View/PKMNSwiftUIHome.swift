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
  
  /// The searchable `String` to search the `Pokemon`.
  @State var searchString = String()
  
  // MARK: - Computed Properties
  
  /// The `PKMNModel` handeld by the `View`.
  @State private var model: PKMNHomeModel?
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  var assembler: PKMNSwiftUIAssembler
  
  // MARK: - View
  
  public var body: some View {
    NavigationView {
      if let model = model {
        ScrollView {
          ForEach(model.pokemonList) { pokemon in
            #warning("Substitute it with the detail")
            NavigationLink(destination: assembler.home) {
              PKMNHomeCell(pokemon: pokemon)
            }
          }
          .padding(.all)
        }
        .navigationTitle(model.title)
      }
    }
    .searchable(text: $searchString)
    .onChange(of: searchString, perform: { newValue in
      viewModel.searchByName(name: newValue)
    })
    .onAppear {
      viewModel.loadHome(queryItems: nil)
    }
    .handleLoadingState(state: viewModel.$loadingState) { model in
      self.model = model
    }
  }
}
