//
//  PKMNStatsView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Foundation
import UIKit
import Anchorage

class PKMNStatsView: PKMNView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(mainScrollViewContainer)
        mainScrollViewContainer.addSubview(mainStackViewContainer)
    }
    
    private func configureConstraints() {
        mainScrollViewContainer.edgeAnchors /==/ edgeAnchors
        mainStackViewContainer.edgeAnchors /==/ mainScrollViewContainer.edgeAnchors
        mainStackViewContainer.widthAnchor /==/ mainScrollViewContainer.widthAnchor
    }
    
    func configure(stats: [Stat]) {
        stats.forEach { stat in
            let statView = PKMNSingleStatView()
            statView.configure(stat: stat)
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
