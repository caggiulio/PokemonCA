//
//  PKMNButtonStyles.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

public struct PKMNButtonStyles {
    private let backgroundColor: UIColor?
    private let font: UIFont?
    private let fontColor: UIColor
    private let insets: UIEdgeInsets
    private let titleInsets: UIEdgeInsets
    private let imageInsets: UIEdgeInsets
    private let cornerRadius: CGFloat
    private let borderWidth: CGFloat
    private let borderColor: UIColor
    private let tintColor: UIColor?
    
    public init(backgroundColor: UIColor? = .clear,
         font: UIFont? = nil,
         fontColor: UIColor = .white,
         insets: UIEdgeInsets = .zero,
         titleInsets: UIEdgeInsets = .zero,
         imageInsets: UIEdgeInsets = .zero,
         borderWidth: CGFloat = 1,
         borderColor: UIColor = .clear,
         cornerRadius: CGFloat = 5,
         tintColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        self.font = font
        self.fontColor = fontColor
        self.insets = insets
        self.titleInsets = titleInsets
        self.imageInsets = imageInsets
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.tintColor = tintColor
    }
    
    public func apply(to button: UIButton?) {
        guard let button = button else { return }
        button.titleLabel?.font = font
        button.titleLabel?.textColor = fontColor
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byClipping
        button.contentEdgeInsets = insets
        button.titleEdgeInsets = titleInsets
        button.imageEdgeInsets = imageInsets
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
        button.setTitleColor(fontColor, for: .normal)
        button.setTitleColor(fontColor.withAlphaComponent(0.4), for: .highlighted)

        button.setTitle(button.currentTitle, for: UIControl.State())
            
        if let backgroundColor = backgroundColor {
            button.backgroundColor = backgroundColor
        }
        
        if let tintColor = tintColor {
            button.tintColor = tintColor
        }
    }
}
public enum ButtonStyles {
    public static let primaryButton = PKMNButtonStyles(backgroundColor: PKMNThemeManager.currentTheme().primaryColor, font: PKMNThemeManager.currentTheme().primaryBoldFont.font(size: 20), fontColor: UIColor.white, insets: .init(top: 0, left: 32, bottom: 0, right: 32), tintColor: UIColor.white)
}
