//
//  PKMNErrorView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Anchorage
import Foundation

public class PKMNErrorView: UIView {
  private var background: UIView = {
    var view = UIView(frame: .zero)
    view.backgroundColor = PKMNThemeManager.currentTheme().backgroundColor

    return view
  }()

  private var textLabel: UILabel = {
    var label = UILabel(frame: .zero)
    label.textAlignment = .center
    label.numberOfLines = 0
    LabelStyles.primaryLabel.apply(to: label)
    label.text = PKMNString.resourceNotFound

    return label
  }()

  override public init(frame: CGRect) {
    super.init(frame: frame)

    configureUI()
    configureConstraints()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func draw(_ rect: CGRect) {
    super.draw(rect)

    clipsToBounds = true
    layer.cornerRadius = 10
  }

  func configureUI() {
    addSubview(background)
    background.addSubview(textLabel)
  }

  func configureConstraints() {
    background.edgeAnchors /==/ edgeAnchors
    textLabel.edgeAnchors /==/ background.edgeAnchors
  }
}
