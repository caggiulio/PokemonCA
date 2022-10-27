//
//  PKMNString.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNString

public struct PKMNString {
  public static let standardError = PKMNString.tr("Localizable", "standard_error")
  public static let standardSearch = PKMNString.tr("Localizable", "standard_search")
  public static let resourceNotFound = PKMNString.tr("Localizable", "resource_not_found")
  public static let homeTitle = PKMNString.tr("Localizable", "home_title")
}

extension PKMNString {
  public struct AppIntents {
    public static let title = PKMNString.tr("Localizable", "appIntents.open.title")
    public static let description = PKMNString.tr("Localizable", "appIntents.open.description")
    public static let pokemonParamaterDescription = PKMNString.tr("Localizable", "appIntents.open.pokemonParameterDescription")
    public static let dialog = PKMNString.tr("Localizable", "appIntents.open.dialog")
  }
}

extension PKMNString {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = PKMNConstants.mainBundle().localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
