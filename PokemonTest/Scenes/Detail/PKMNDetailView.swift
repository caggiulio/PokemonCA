//
//  PKMNDetailView.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Anchorage
import Foundation
import UIKit

public class PKMNDetailView: PKMNView<Pokemon> {
  private var nameLabel: UILabel = {
    var label = UILabel()
    LabelStyles.titleLabel.apply(to: label)

    return label
  }()

  private var pokeballImage: UIImageView = {
    var imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = AppAsset.pokeball.image.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = PKMNThemeManager.currentTheme().secondaryColor.withAlphaComponent(0.75)

    return imageView
  }()

  private var pokemonImage: UIImageView = {
    var imageView = UIImageView()

    return imageView
  }()

  private var statsContainerView: UIView = {
    var view = UIView()
    view.backgroundColor = PKMNThemeManager.currentTheme().backgroundColor
    view.clipsToBounds = true

    return view
  }()

  private var statsView: PKMNStatsView = PKMNStatsView()

  private var abilitiesView: PKMNAbilitiesView = {
    var view = PKMNAbilitiesView()

    return view
  }()

  override public func layoutSubviews() {
    super.layoutSubviews()

    statsContainerView.layer.cornerRadius = 10
  }

  override func configureUI() {
    addSubview(nameLabel)
    addSubview(statsContainerView)
    statsContainerView.addSubview(abilitiesView)
    statsContainerView.addSubview(statsView)
    addSubview(pokeballImage)
    pokeballImage.addSubview(pokemonImage)
  }

  override func configureConstraints() {
    statsContainerView.bottomAnchor /==/ bottomAnchor
    statsContainerView.leadingAnchor /==/ leadingAnchor
    statsContainerView.trailingAnchor /==/ trailingAnchor
    statsContainerView.heightAnchor /==/ heightAnchor * 0.7

    pokeballImage.centerXAnchor /==/ centerXAnchor
    pokeballImage.widthAnchor /==/ widthAnchor * 0.5
    pokeballImage.heightAnchor /==/ pokeballImage.widthAnchor
    pokeballImage.centerYAnchor /==/ statsContainerView.centerYAnchor * 0.4

    pokemonImage.centerXAnchor /==/ pokeballImage.centerXAnchor
    pokemonImage.centerYAnchor /==/ pokeballImage.centerYAnchor
    pokemonImage.heightAnchor /==/ pokeballImage.widthAnchor * 0.9
    pokemonImage.widthAnchor /==/ pokemonImage.heightAnchor

    nameLabel.bottomAnchor /==/ pokeballImage.topAnchor - 10
    nameLabel.topAnchor />=/ safeAreaLayoutGuide.topAnchor - 10
    nameLabel.centerXAnchor /==/ centerXAnchor

    abilitiesView.topAnchor /==/ pokeballImage.bottomAnchor + 5
    abilitiesView.leadingAnchor /==/ leadingAnchor + 15
    abilitiesView.trailingAnchor /==/ trailingAnchor - 15
    abilitiesView.heightAnchor /==/ 80

    statsView.topAnchor /==/ abilitiesView.bottomAnchor + 5
    statsView.leadingAnchor /==/ leadingAnchor + 15
    statsView.trailingAnchor /==/ trailingAnchor - 15
    statsView.bottomAnchor /==/ safeAreaLayoutGuide.bottomAnchor - 15
  }
  
  override func update(model: Pokemon?) {
    if let pokemon = model {
      nameLabel.text = pokemon.name.capitalized
      statsView.model = StatArray(array: model?.stats)
      abilitiesView.model = AbilitiesArray(array: model?.abilities)
      pokemonImage.download(from: pokemon.frontImage.stringURL, contentMode: .scaleAspectFill, fillBackgroundWithView: self) { colors in
        self.statsView.configureColors(colors: colors)
      }
    }
  }
}
