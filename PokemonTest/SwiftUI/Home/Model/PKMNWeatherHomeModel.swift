//
//  PKMNWeatherHomeModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/11/22.
//

import SwiftUI

/// The model for the `PKMNWeatherInformation`.
struct PKMNHomeWeatherModel {
  /// The title of the `View`.
  let title: String
  
  /// The icon for the current weather information.
  let icon: Image
  
  // MARK: - Init
  
  /// The init of the `View`.
  /// - Parameters:
  ///   - title: the title of the `View`.
  ///   - icon: the icon for the current weather information.
  init(title: String, icon: Image) {
    self.title = title
    self.icon = icon
  }
}
