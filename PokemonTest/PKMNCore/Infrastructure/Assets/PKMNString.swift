//
//  PKMNString.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNString

struct PKMNString {
  static let standardError = PKMNString.tr("Localizable", "standard_error")
  static let standardSearch = PKMNString.tr("Localizable", "standard_search")
  static let resourceNotFound = PKMNString.tr("Localizable", "resource_not_found")
  static let homeTitle = PKMNString.tr("Localizable", "home_title")
}

extension PKMNString {
  struct AppIntents {
    static let title = PKMNString.tr("Localizable", "appIntents.open.title")
    static let description = PKMNString.tr("Localizable", "appIntents.open.description")
    static let pokemonParamaterDescription = PKMNString.tr("Localizable", "appIntents.open.pokemonParameterDescription")
    static let dialog = PKMNString.tr("Localizable", "appIntents.open.dialog")
  }
  
  struct AppShortcuts {
    static let showPokemons = PKMNString.tr("AppShortcuts", "shortcut.show.pokemons")
  }
}

extension PKMNString {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = PKMNConstants.mainBundle().localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
