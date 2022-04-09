//
//  PKMNHomeCollectionViewCell.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import Anchorage

class PKMNHomeCollectionViewCell: UICollectionViewCell {
        
    private var pokeballImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppAsset.pokeball.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = PKMNThemeManager.currentTheme().tertiaryColor
        
        return imageView
    }()
    
    private var pokemonImage: UIImageView = {
        var imageView = UIImageView()
        
        return imageView
    }()
    
    private var rankingLabel: UILabel = {
        var label = UILabel()
        LabelStyles.primaryLabel.apply(to: label)
        
        return label
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        LabelStyles.primaryLabel.apply(to: label)
        
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankingLabel.text = nil
        nameLabel.text = nil
        pokemonImage.image = nil
        contentView.backgroundColor = nil
    }
    
    // MARK: - Configure methods
    
    private func configureUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = PKMNThemeManager.currentTheme().backgroundColor
        
        contentView.addSubview(rankingLabel)
        
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(pokeballImage)
        
        pokeballImage.addSubview(pokemonImage)
    }
    
    private func configureConstraints() {
            pokeballImage.centerXAnchor /==/ contentView.centerXAnchor
            pokeballImage.centerYAnchor /==/ contentView.centerYAnchor - 20
            pokeballImage.heightAnchor /==/ 120
            pokeballImage.widthAnchor /==/ 120
            
            pokemonImage.centerXAnchor /==/ pokeballImage.centerXAnchor
            pokemonImage.centerYAnchor /==/ pokeballImage.centerYAnchor
            pokemonImage.heightAnchor /==/ 90
            pokemonImage.widthAnchor /==/ 90
            
            rankingLabel.topAnchor /==/ pokeballImage.bottomAnchor + 5
            rankingLabel.centerXAnchor /==/ pokeballImage.centerXAnchor
            
            nameLabel.topAnchor /==/ rankingLabel.bottomAnchor
            nameLabel.centerXAnchor /==/ rankingLabel.centerXAnchor
    }
    
    func configure(pokemon: PokemonListItem) {
        nameLabel.text = pokemon.name.capitalized
        rankingLabel.text = "#\(pokemon.ranking)"
        pokemonImage.download(from: pokemon.imageURL, contentMode: .scaleAspectFit, fillBackgroundWithView: contentView)
    }
}
