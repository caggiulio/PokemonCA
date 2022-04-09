//
//  PKMNView.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit
import Anchorage

public class PKMNView: UIView {
    var modalViews: [PKMNLoader] = []
    
    private var errorView: PKMNErrorView = {
        var view = PKMNErrorView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = PKMNThemeManager.currentTheme().backgroundColor
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showErrorView() {
        addSubview(errorView)
        errorView.edgeAnchors /==/ edgeAnchors
    }
    
    func hideErrorView() {
        errorView.removeFromSuperview()
    }
}
