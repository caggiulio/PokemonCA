//
//  PKMNLoader.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit
import Anchorage

public class PKMNLoader: UIView {
    
    private let backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        return view
    }()
    
    let loader: UIImageView = {
        var imageView: UIImageView = UIImageView(image: AppAsset.pokeball.image.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = PKMNThemeManager.currentTheme().primaryColor
        
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(loader)
        loader.rotate()
    }
    
    private func configureConstraints() {
        backgroundView.edgeAnchors /==/ edgeAnchors
        
        loader.centerAnchors /==/ backgroundView.centerAnchors
        loader.widthAnchor /==/ 150
        loader.heightAnchor /==/ 150
    }
}

fileprivate extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
}
