//
//  PKMNThemeManager.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

/// This will let you use a theme in the app.
enum PKMNThemeManager {
  static var customTheme: PKMNTheme!

  /// ThemeManager
  static func currentTheme() -> PKMNTheme {
    return customTheme
  }

  static func applyTheme(theme: PKMNTheme) {
    PKMNThemeManager.customTheme = theme
    /// You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = theme.primaryColor
    
    let navigationBarAppeareance = UINavigationBarAppearance()
    
    navigationBarAppeareance.backgroundColor = theme.navigationBarBackgroundColor
    navigationBarAppeareance.shadowImage = UIImage()
    navigationBarAppeareance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.navigationBarForegroundColor, NSAttributedString.Key.font: PKMNThemeManager.currentTheme().primaryBoldFont.font(size: 20)]
    navigationBarAppeareance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.navigationBarForegroundColor, NSAttributedString.Key.font: PKMNThemeManager.currentTheme().primaryBoldFont.font(size: 40)]

    // MARK: - UINavigationBar Appearance
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().tintColor = theme.navigationBarForegroundColor
    UINavigationBar.appearance().barTintColor = theme.navigationBarBackgroundColor
    UINavigationBar.appearance().compactScrollEdgeAppearance = navigationBarAppeareance
    UINavigationBar.appearance().compactAppearance = navigationBarAppeareance
    UINavigationBar.appearance().standardAppearance = navigationBarAppeareance
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppeareance
    
    // MARK: - UITextField Appearance
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: PKMNThemeManager.currentTheme().tertiaryColor]
  }
}
