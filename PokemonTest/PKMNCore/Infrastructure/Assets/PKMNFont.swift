//
//  PKMNFont.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

// MARK: - PKMNFont

struct PKMNFont {
  static var all: Set<String> = []

  func font(size: CGFloat) -> UIFont {
    if let font = UIFont(name: rawString!, size: size) {
      return font
    } else {
      fatalError("No font found!")
    }
  }

  let rawString: String?

  init() {
    rawString = nil
  }
}

// MARK: ExpressibleByStringLiteral

extension PKMNFont: ExpressibleByStringLiteral {
  init(stringLiteral value: String) {
    rawString = value
    register()
  }

  init(extendedGraphemeClusterLiteral value: String) {
    rawString = value
    register()
  }

  init(unicodeScalarLiteral value: String) {
    rawString = value
    register()
  }

  private func register() {
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    return PKMNConstants.mainBundle().url(forResource: (rawString ?? "") + ".ttf", withExtension: nil)
  }
}

// MARK: FontBookie

extension PKMNFont: FontBookie {
  static func == (lhs: PKMNFont, rhs: PKMNFont) -> Bool {
    if let lhsRaw = lhs.rawString { PKMNFont.all.insert(lhsRaw) }
    if let rhsRaw = rhs.rawString { PKMNFont.all.insert(rhsRaw) }

    return lhs.rawString == rhs.rawString
  }
}

// MARK: - FontBookie

private protocol FontBookie: Equatable {
  func font(size: CGFloat) -> UIFont
}
