//
//  PKMNTheme.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

struct PKMNTheme {
  /// Colors
  var primaryColor: UIColor
  var secondaryColor: UIColor
  var tertiaryColor: UIColor
  var backgroundColor: UIColor
  var navigationBarBackgroundColor: UIColor
  var navigationBarForegroundColor: UIColor

  /// Primary Font
  var primaryFont: PKMNFont
  var primaryBoldFont: PKMNFont
  var primaryMediumFont: PKMNFont
  var primaryItalicFont: PKMNFont

  init(primaryFont: PKMNFont, primaryBoldFont: PKMNFont, primaryMediumFont: PKMNFont, primaryItalicFont: PKMNFont) {
    primaryColor = AppAsset.primary.color
    secondaryColor = AppAsset.secondary.color
    tertiaryColor = AppAsset.tertiary.color
    navigationBarBackgroundColor = AppAsset.primary.color
    navigationBarForegroundColor = AppAsset.secondary.color
    backgroundColor = AppAsset.background.color
    self.primaryFont = primaryFont
    self.primaryBoldFont = primaryBoldFont
    self.primaryMediumFont = primaryMediumFont
    self.primaryItalicFont = primaryItalicFont
  }
}
