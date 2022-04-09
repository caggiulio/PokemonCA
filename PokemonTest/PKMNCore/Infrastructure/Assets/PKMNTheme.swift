//
//  PKMNTheme.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

public struct PKMNTheme {
  /// Colors
  public var primaryColor: UIColor
  public var secondaryColor: UIColor
  public var tertiaryColor: UIColor
  public var backgroundColor: UIColor
  public var navigationBarBackgroundColor: UIColor
  public var navigationBarForegroundColor: UIColor

  /// Primary Font
  public var primaryFont: PKMNFont
  public var primaryBoldFont: PKMNFont
  public var primaryMediumFont: PKMNFont
  public var primaryItalicFont: PKMNFont

  public init(primaryFont: PKMNFont, primaryBoldFont: PKMNFont, primaryMediumFont: PKMNFont, primaryItalicFont: PKMNFont) {
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
