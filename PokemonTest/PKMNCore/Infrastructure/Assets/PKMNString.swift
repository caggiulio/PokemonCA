//
//  PKMNString.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - PKMNString

public enum PKMNString {
  public static let standardError = PKMNString.tr("Localizable", "standard_error")
  public static let standardSearch = PKMNString.tr("Localizable", "standard_search")
  public static let resourceNotFound = PKMNString.tr("Localizable", "resource_not_found")
  public static let homeTitle = PKMNString.tr("Localizable", "home_title")
}

extension PKMNString {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = PKMNConstants.mainBundle().localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
