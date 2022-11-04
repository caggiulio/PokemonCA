//
//  PKMNSwiftUIToastModel.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 04/11/22.
//

import SwiftUI

/// The model for the `PKMNSwiftUIToast`.
struct PKMNSwiftUIToastModel {
  // MARK: - Stored Properties
  
  /// The status of the `PKMNSwiftUIToast`.
  let status: PKMNSwiftUIToast.Status
  
  /// The message to show.
  let message: String
  
  // MARK: - Computed Properties
  
  /// The background `Color` of the `View`.
  var backgroundColor: Color {
    status == .success ? .green : .red
  }
}
