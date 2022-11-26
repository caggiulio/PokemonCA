//
//  PKMNLocationProtocol.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/11/22.
//

import Foundation

/// The protocol with the location methods.
protocol PKMNLocationProtocol {
  /// Get the current location.
  func getCurrentLocation() async throws -> CurrentLocation?
}
