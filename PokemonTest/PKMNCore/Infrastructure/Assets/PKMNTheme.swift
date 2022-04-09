//
//  PKMNTheme.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

public struct PKMNTheme {
    /// Colors
    public var primaryColor: UIColor
    public var secondaryColor: UIColor
    public var tertiaryColor: UIColor
    public var backgroundColor: UIColor
    public var navigationBarBackgroundColor: UIColor
    public var navigationBarForegroundColor: UIColor
    
    /// Primary Font
    public var primaryFont: PKMNFont
    public var primaryBoldFont: PKMNFont
    public var primaryMediumFont: PKMNFont
    public var primaryItalicFont: PKMNFont
    
    public init(primaryFont: PKMNFont, primaryBoldFont: PKMNFont, primaryMediumFont: PKMNFont, primaryItalicFont: PKMNFont) {
        self.primaryColor = AppAsset.primary.color
        self.secondaryColor = AppAsset.secondary.color
        self.tertiaryColor = AppAsset.tertiary.color
        self.navigationBarBackgroundColor = AppAsset.primary.color
        self.navigationBarForegroundColor = AppAsset.secondary.color
        self.backgroundColor = AppAsset.background.color
        self.primaryFont = primaryFont
        self.primaryBoldFont = primaryBoldFont
        self.primaryMediumFont = primaryMediumFont
        self.primaryItalicFont = primaryItalicFont
    }
}
