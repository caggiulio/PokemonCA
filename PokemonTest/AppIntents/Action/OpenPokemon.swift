//
//  OpenPokemon.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import AppIntents
import SwiftUI

/// This is the real implementation of `AppIntent`. Is the action to show the information about a `PokemonAppEntity`.
@available(iOS 16, *)
struct OpenPokemon: AppIntent {
  /// The title of the action in the `Shortcut` app.
  static var title: LocalizedStringResource = LocalizedStringResource(stringLiteral: PKMNString.AppIntents.title)
  
  /// The description of the action.
  static var description: IntentDescription = IntentDescription(stringLiteral: PKMNString.AppIntents.description)
  
  /// Authentication policies to apply when running an app intent.
  static var authenticationPolicy: IntentAuthenticationPolicy = IntentAuthenticationPolicy.alwaysAllowed
  
  /// Wheter or not the app should be open or not.
  static var openAppWhenRun: Bool = false
  
  /// The dynamic lookup parameter.
  @Parameter(title: LocalizedStringResource(stringLiteral: PKMNString.AppIntents.pokemonParamaterDescription), requestValueDialog: IntentDialog(stringLiteral: PKMNString.AppIntents.dialog))
  var pokemon: PokemonAppEntity
  
  @MainActor
  func perform() async throws -> some ReturnsValue<PokemonAppEntity> {
    return .result(value: pokemon, view: PokemonInformation(pokemon: pokemon))
  }
}
