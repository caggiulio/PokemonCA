//
//  PKMNSingleAbilityView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Anchorage
import Foundation
import UIKit

class PKMNSingleAbilityView: PKMNView<Ability> {
  private var pillContainerView: UIView = {
    var view = UIView()
    view.backgroundColor = PKMNThemeManager.currentTheme().secondaryColor
    view.clipsToBounds = true

    return view
  }()

  private var abilityLabel: UILabel = {
    var label = UILabel()
    LabelStyles.secondaryLabel.apply(to: label)
    label.textAlignment = .center

    return label
  }()

  override func layoutSubviews() {
    super.layoutSubviews()

    pillContainerView.layer.cornerRadius = 10
  }

  override func configureUI() {
    addSubview(pillContainerView)
    pillContainerView.addSubview(abilityLabel)
  }

  override func configureConstraints() {
    pillContainerView.edgeAnchors /==/ edgeAnchors
    abilityLabel.edgeAnchors /==/ pillContainerView.edgeAnchors
  }

  override func update(model: Ability?) {
    abilityLabel.text = model?.name
  }
}
