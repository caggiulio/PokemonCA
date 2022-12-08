//
//  PKMNDetailsAbilitiesList.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 11/11/22.
//

import SwiftUI

/// The `View` for list of the abilities.
struct PKMNDetailAbilitiesList: View {
  // MARK: - Stored Properties
  
  /// The list of `AbilityModel`.
  private let abilities: [AbilityModel]
  
  // MARK: - Init
  
  /// The init of the `View`.
  /// - Parameter abilities: the list of `AbilityModel`.
  init(abilities: [AbilityModel]) {
    self.abilities = abilities
  }
  
  // MARK: - View
  
  var body: some View {
    VStack {
      ForEach(abilities) { ability in
        AbilityView(model: ability)
      }
    }
    .background(Color(uiColor: AppAsset.tertiary.color))
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}
