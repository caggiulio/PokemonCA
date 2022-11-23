//
//  PKMNString.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import AppIntents
import Foundation

// MARK: - PKMNString

struct PKMNString {
  static let standardError = PKMNString.tr("Localizable", "standard_error")
  static let standardSearch = PKMNString.tr("Localizable", "standard_search")
  static let resourceNotFound = PKMNString.tr("Localizable", "resource_not_found")
  static let homeTitle = PKMNString.tr("Localizable", "home_title")
}

extension PKMNString {
  @available(iOS 16, *)
  struct AppIntents {
    static let title = PKMNString.trLocalizableStringResource("Localizable", "appIntents.open.title")
    static let description = PKMNString.trLocalizableStringResource("Localizable", "appIntents.open.description")
    static let pokemonParamaterDescription = PKMNString.trLocalizableStringResource("Localizable", "appIntents.open.pokemonParameterDescription")
    static let dialog = PKMNString.trLocalizableStringResource("Localizable", "appIntents.open.dialog")
  }
}

extension PKMNString {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = PKMNConstants.mainBundle().localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
  
  @available(iOS 16, *)
  private static func trLocalizableStringResource(_ table: String, _ key: StaticString) -> LocalizedStringResource {
    LocalizedStringResource(key, defaultValue: String.LocalizationValue(String()), table: table, locale: .current, bundle: .main, comment: nil)
  }
}
