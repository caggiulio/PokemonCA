//
//  ShortcutProvider.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 10/11/22.
//

import AppIntents

@available(iOS 16.0, *)
/// The `AppShortcutsProvider` for `OpenPokemon()` `AppIntent`.
struct OpenPokemonShortcut: AppShortcutsProvider {
  @AppShortcutsBuilder
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: OpenPokemon(),
      phrases: [AppShortcutPhrase(stringLiteral: PKMNString.AppShortcuts.showPokemons)]
    )
  }
}
