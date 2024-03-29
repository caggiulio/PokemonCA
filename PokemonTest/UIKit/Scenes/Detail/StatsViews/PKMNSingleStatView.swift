//
//  PKMNSingleStatView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Anchorage
import Foundation
import UIKit

class PKMNSingleStatView: PKMNView<Stat> {
  private let progressView: UIProgressView = {
    var view = UIProgressView(frame: .zero)
    view.clipsToBounds = true
    view.layer.cornerRadius = 7
    view.trackTintColor = PKMNThemeManager.currentTheme().tertiaryColor
    view.progressTintColor = PKMNThemeManager.currentTheme().primaryColor

    view.layer.sublayers?[1].cornerRadius = 5
    view.subviews[1].clipsToBounds = true

    return view
  }()

  private var statNameLabel: UILabel = {
    var label = UILabel()
    LabelStyles.primaryLabel.apply(to: label)

    return label
  }()

  private var statValueLabel: UILabel = {
    var label = UILabel()
    LabelStyles.primaryLabel.apply(to: label)

    return label
  }()

  override func configureUI() {
    addSubview(progressView)
    addSubview(statValueLabel)
    addSubview(statNameLabel)
  }

  override func configureConstraints() {
    progressView.leadingAnchor /==/ leadingAnchor + 15
    progressView.topAnchor /==/ topAnchor + 5
    progressView.heightAnchor /==/ 20
    progressView.trailingAnchor /==/ statValueLabel.leadingAnchor - 20

    statValueLabel.centerYAnchor /==/ progressView.centerYAnchor
    statValueLabel.bottomAnchor /==/ bottomAnchor - 5
    statValueLabel.trailingAnchor /==/ trailingAnchor

    statNameLabel.topAnchor /==/ progressView.bottomAnchor
    statNameLabel.leadingAnchor /==/ progressView.leadingAnchor
    statNameLabel.trailingAnchor /==/ trailingAnchor
    statNameLabel.bottomAnchor /==/ bottomAnchor
  }

  override func update(model: Stat?) {
    guard let stat = model else {
      return
    }
    
    configureUI()
    configureConstraints()

    statNameLabel.text = stat.name
    statValueLabel.text = "\(stat.baseStat)"
    progressView.setProgress(stat.percentStat, animated: false)
  }

  func configureColors(colors: UIImage.Colors?) {
    let progressViewPreviousProgress = progressView.progress
    progressView.trackTintColor = colors?.primary
    progressView.progressTintColor = colors?.background
    /// Reset progress
    progressView.progress = 0
    /// Adds delay to allow a better visualization
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .curveEaseInOut) {
        self.progressView.setProgress(progressViewPreviousProgress, animated: true)
      }
    }
  }
}
