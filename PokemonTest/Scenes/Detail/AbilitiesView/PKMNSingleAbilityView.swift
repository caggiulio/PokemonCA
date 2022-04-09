//
//  PKMNSingleAbilityView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Foundation
import UIKit
import Anchorage

class PKMNSingleAbilityView: PKMNView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        pillContainerView.layer.cornerRadius = 10
    }
    
    private func configureUI() {
        addSubview(pillContainerView)
        pillContainerView.addSubview(abilityLabel)
    }
    
    private func configureConstraints() {
        pillContainerView.edgeAnchors /==/ edgeAnchors
        abilityLabel.edgeAnchors /==/ pillContainerView.edgeAnchors
    }
    
    func configure(ability: Ability) {
        abilityLabel.text = ability.name
    }
}
