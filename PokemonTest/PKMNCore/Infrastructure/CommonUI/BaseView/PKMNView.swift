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
  var modalViews: [PKMNLoader] = []

  private var errorView: PKMNErrorView = {
    var view = PKMNErrorView()

    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = PKMNThemeManager.currentTheme().backgroundColor
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func showErrorView() {
    addSubview(errorView)
    errorView.edgeAnchors /==/ edgeAnchors
  }

  func hideErrorView() {
    errorView.removeFromSuperview()
  }
  
  func update(model: Model?) {}
}
