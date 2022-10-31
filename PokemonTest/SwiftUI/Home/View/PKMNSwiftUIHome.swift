//
//  Main.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

/// The `View` for the home.
struct PKMNSwiftUIHome: View {
  // MARK: - Stored Properties
  
  /// The `PKMNSwiftUIViewModel` of the view.
  let viewModel: PKMNHomeSwiftUIViewModel
  
  /// The searchable `String` to search the `Pokemon`.
  @State private var searchString = String()
  
  // MARK: - Computed Properties
  
  /// The `PKMNModel` handeld by the `View`.
  @State private var model: PKMNHomeModel?
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  var assembler: PKMNSwiftUIAssembler
  
  // MARK: - View
  
  var body: some View {
    NavigationView {
      if let model = model {
        makeBody(model: model)
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

// MARK: - Private View

private extension PKMNSwiftUIHome {
  /// Builds the body of the `View` passing the model.
  /// - Parameter model: The `PKMNModel` handeld by the `View`.
  @MainActor
  func makeBody(model: PKMNHomeModel) -> some View {
    ScrollView {
      ForEach(model.isFiltered ? model.filteredPokemonList : model.pokemonList) { pokemon in
        NavigationLink(destination: assembler.detail(id: pokemon.id)) {
          PKMNHomeCell(pokemon: pokemon)
        }
      }
      .padding(.horizontal)
    }
    .onReachTheEnd {
      viewModel.getNextPage()
    }
    .navigationTitle(model.title)
  }
}
