//
//  PKMNAbilitiesView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Anchorage
import Foundation
import UIKit

class PKMNAbilitiesView: PKMNView<AbilitiesArray> {
  private var mainScrollViewContainer: UIScrollView = {
    var scrollView = UIScrollView()

    return scrollView
  }()

  private var mainStackViewContainer: UIStackView = {
    var stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 5

    return stackView
  }()

  override func configureUI() {
    addSubview(mainScrollViewContainer)
    mainScrollViewContainer.addSubview(mainStackViewContainer)
  }

  override func configureConstraints() {
    mainScrollViewContainer.edgeAnchors /==/ edgeAnchors
    mainStackViewContainer.edgeAnchors /==/ mainScrollViewContainer.edgeAnchors
    mainStackViewContainer.widthAnchor /==/ mainScrollViewContainer.widthAnchor
  }

  override func update(model: AbilitiesArray?) {
    model?.array?.forEach { ability in
      let abilityView = PKMNSingleAbilityView()
      abilityView.heightAnchor /==/ 30
      mainStackViewContainer.addArrangedSubview(abilityView)
      abilityView.model = ability
    }
  }
}
