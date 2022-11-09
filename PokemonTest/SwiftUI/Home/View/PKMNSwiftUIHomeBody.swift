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
  
  // MARK: - Interaction
  
  /// The list reach the end.
  var listReachEnd: Interaction?
  
  /// The list reach the end.
  var pokemonDidSelect: CustomInteraction<String>?
    
  // MARK: - Init
  
  /// The init of the `View`.
  /// - Parameters:
  ///   - model: the model handeld by the `View`.
  ///   - listReachEnd: the list reach the end.
  ///   - pokemonDidSelect: the user selected a `Pokemon`.
  init(model: PKMNHomeBodyModel, listReachEnd: Interaction?, pokemonDidSelect: CustomInteraction<String>?) {
    self.model = model
    self.listReachEnd = listReachEnd
    self.pokemonDidSelect = pokemonDidSelect
  }
  
  var body: some View {
    ScrollView {
      ForEach(model.isFiltered ? model.filteredPokemonList : model.pokemonList) { pokemon in
        PKMNHomeCell(pokemon: pokemon)
          .onTapGesture {
            pokemonDidSelect?(pokemon.id)
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
