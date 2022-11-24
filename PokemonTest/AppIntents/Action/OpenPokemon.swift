//
//  CatchPokemon.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import AppIntents
import SwiftUI

/// This is the real implementation of `AppIntent`. Is the action to show the information about a `PokemonAppEntity`.
@available(iOS 16, *)
struct CatchPokemon: AppIntent {
  /// The title of the action in the `Shortcut` app.
  static var title: LocalizedStringResource = PKMNString.AppIntents.title
  
  /// The description of the action.
  static var description: IntentDescription = IntentDescription(stringLiteral: String(localized: PKMNString.AppIntents.description))
  
  /// Authentication policies to apply when running an app intent.
  static var authenticationPolicy = IntentAuthenticationPolicy.alwaysAllowed
  
  /// Wheter or not the app should be open or not.
  static var openAppWhenRun = false
  
  /// The dynamic lookup parameter.
  @Parameter(title: "Pokemon")
  var pokemon: PokemonAppEntity?
  
  @MainActor
  func perform() async throws -> some ReturnsValue<PokemonAppEntity> {
    let pokemonToCatch: PokemonAppEntity
    if let pokemon = pokemon {
      pokemonToCatch = pokemon
    } else {
      pokemonToCatch = try await $pokemon.requestDisambiguation(among: try await IntentsLogic.FetchData.Pokemons.execute(), dialog: IntentDialog(stringLiteral: String(localized: PKMNString.AppIntents.dialog)))
    }
    return .result(value: pokemonToCatch, view: PokemonInformation(pokemon: pokemonToCatch))
  }
}
