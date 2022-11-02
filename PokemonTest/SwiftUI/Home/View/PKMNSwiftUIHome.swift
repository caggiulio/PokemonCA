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
  @StateObject var viewModel: PKMNHomeSwiftUIViewModel
  
  /// The searchable `String` to search the `Pokemon`.
  @State private var searchString = String()
  
  // MARK: - Computed Properties
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  var assembler: PKMNSwiftUIAssembler
  
  // MARK: - View
  
  var body: some View {
    PKMNBaseSwiftUIView({
      NavigationView {
        if let model = viewModel.lastValueModel {
          PKMNHomeBody(model: model.bodyModel, assembler: assembler) {
            viewModel.getNextPage()
          }
        }
      }
      .searchable(text: $searchString)
      .onChange(of: searchString, perform: { newValue in
        viewModel.searchByName(name: newValue)
      })
      .onAppear {
        viewModel.loadHome(queryItems: nil)
      }
    }, viewModel: viewModel)
  }
}

// MARK: - Private View

private extension PKMNSwiftUIHome {
  /// The body of the `View`.
  struct PKMNHomeBody: View {
    // MARK: - Stored Properties
    
    /// The model handeld by the `View`.
    private var model: PKMNHomeBodyModel
    
    /// The responsible of the assemble of the `View` used to assemble a view for navigation.
    private var assembler: PKMNSwiftUIAssembler
    
    // MARK: - Interaction
    
    /// The list reach the end.
    var listReachEnd: Interaction?
    
    // MARK: - Init
    
    /// The init of the `View`.
    /// - Parameters:
    /// - model: the model handeld by the `View`.
    /// - assembler: the responsible of the assemble of the `View` used to assemble a view for navigation.
    /// - listReachEnd: the list reach the end.
    init(model: PKMNHomeBodyModel, assembler: PKMNSwiftUIAssembler, listReachEnd: Interaction?) {
      self.model = model
      self.assembler = assembler
      self.listReachEnd = listReachEnd
    }
    
    var body: some View {
      ScrollView {
        ForEach(model.isFiltered ? model.filteredPokemonList : model.pokemonList) { pokemon in
          NavigationLink(destination: assembler.detail(id: pokemon.id)) {
            PKMNHomeCell(pokemon: pokemon)
          }
          .isDetailLink(true)
        }
        .padding(.horizontal)
      }
      .onReachTheEnd {
        listReachEnd?()
      }
      .navigationTitle(model.title)
    }
  }
}
