//
//  PKMNView.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Anchorage
import Foundation
import UIKit

public class PKMNView<Model: PKMNModel>: UIView {
  
  // MARK: - Computed Properties
  
  /// The modal views for the loaders.
  var modalViews: [PKMNLoader] = []

  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = PKMNThemeManager.currentTheme().backgroundColor
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// The func to override with the correct `Model` to update the view.
  func update(model: Model?) {}
}
