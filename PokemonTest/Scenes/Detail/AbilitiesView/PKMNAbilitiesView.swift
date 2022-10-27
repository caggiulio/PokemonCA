//
//  PKMNAbilitiesView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Anchorage
import Foundation
import UIKit

class PKMNAbilitiesView: PKMNView<Pokemon> {
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

  func configure(abilities: [Ability]) {
    abilities.forEach { ability in
      let abilityView = PKMNSingleAbilityView()
      abilityView.heightAnchor /==/ 30
      mainStackViewContainer.addArrangedSubview(abilityView)
      abilityView.configure(ability: ability)
    }
  }
}
