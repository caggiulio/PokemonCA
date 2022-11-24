//
//  ShortcutProvider.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 10/11/22.
//

import AppIntents

@available(iOS 16.0, *)
/// The `AppShortcutsProvider` for `CatchPokemon()` `AppIntent`.
struct CatchPokemonShortcut: AppShortcutsProvider {
  @AppShortcutsBuilder
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: CatchPokemon(),
      phrases: ["shortcut.show.pokemons"]
    )
  }
}
