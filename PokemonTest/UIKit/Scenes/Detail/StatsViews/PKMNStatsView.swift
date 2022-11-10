//
//  PKMNStatsView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Anchorage
import Foundation
import UIKit

class PKMNStatsView: PKMNView<StatArray> {
  private var mainScrollViewContainer: UIScrollView = {
    var scrollView = UIScrollView()
    
    return scrollView
  }()
  
  private var mainStackViewContainer: UIStackView = {
    var stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.spacing = 20
    
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
  
  override func update(model: StatArray?) {
    guard let stats = model?.array else {
      return
    }
    
    stats.forEach { stat in
      let statView = PKMNSingleStatView()
      statView.model = stat
      mainStackViewContainer.addArrangedSubview(statView)
    }
  }
  
  func configureColors(colors: UIImage.Colors?) {
    mainStackViewContainer.arrangedSubviews.forEach { view in
      if let view = (view as? PKMNSingleStatView) {
        view.configureColors(colors: colors)
      }
    }
  }
}
