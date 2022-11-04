//
//  PKMNSwiftUIHomeBody.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 02/11/22.
//

import SwiftUI

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
  ///   - model: the model handeld by the `View`.
  ///   - assembler: the responsible of the assemble of the `View` used to assemble a view for navigation.
  ///   - listReachEnd: the list reach the end.
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
      }
      .padding(.horizontal)
    }
    .onReachTheEnd {
      listReachEnd?()
    }
    .navigationTitle(model.title)
  }
}
