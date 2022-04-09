//
//  PKMNErrorView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Foundation
import Anchorage

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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureUI()
        configureConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
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

