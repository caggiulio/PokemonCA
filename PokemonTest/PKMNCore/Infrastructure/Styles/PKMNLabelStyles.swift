//
//  PKMNLabelStyles.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

// MARK: - PKMNLabelStyles

struct PKMNLabelStyles {
  private let backgroundColor: UIColor?
  private let font: UIFont?
  private let fontColor: UIColor
  private let minimumScaleFactor: CGFloat
  private let adjustsFontSizeToFitWidth: Bool

  init(
    backgroundColor: UIColor? = nil,
    font: UIFont? = nil,
    fontColor: UIColor = .black,
    minimumScaleFactor: CGFloat = 0.6,
    adjustsFontSizeToFitWidth: Bool = true
  ) {
    self.backgroundColor = backgroundColor
    self.font = font
    self.fontColor = fontColor
    self.minimumScaleFactor = minimumScaleFactor
    self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
  }

  func apply(to label: UILabel?) {
    guard let label = label else { return }

    label.font = font
    label.textColor = fontColor
    label.minimumScaleFactor = minimumScaleFactor
    label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth

    if let backgroundColor = backgroundColor {
      label.backgroundColor = backgroundColor
    }
  }

  func apply(to textView: UITextView?) {
    guard let textView = textView else { return }

    textView.font = font
    textView.textColor = fontColor

    if let backgroundColor = backgroundColor {
      textView.backgroundColor = backgroundColor
    }
  }
}

// MARK: - LabelStyles

enum LabelStyles {
  static let primaryLabel = PKMNLabelStyles(font: PKMNThemeManager.currentTheme().primaryBoldFont.font(size: 18), fontColor: PKMNThemeManager.currentTheme().secondaryColor)

  static let secondaryLabel = PKMNLabelStyles(font: PKMNThemeManager.currentTheme().primaryFont.font(size: 15), fontColor: PKMNThemeManager.currentTheme().tertiaryColor)

  static let titleLabel = PKMNLabelStyles(font: PKMNThemeManager.currentTheme().primaryBoldFont.font(size: 40), fontColor: PKMNThemeManager.currentTheme().tertiaryColor)

  static let toastLabel = PKMNLabelStyles(font: PKMNThemeManager.currentTheme().primaryMediumFont.font(size: 15), fontColor: .white)
}
