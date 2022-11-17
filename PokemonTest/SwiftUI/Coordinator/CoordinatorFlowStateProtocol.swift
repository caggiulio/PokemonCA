//
//  CoordinatorFlowStateProtocol.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 17/11/22.
//

import Foundation

/// The protocol to conform it in order to set the `CoordinatorLink`. It's conform to `ObservableObject`.
protocol CoordinatorFlowStateProtocol: ObservableObject {
  /// The `CoordinatorLink` to set in order to navigate.
  var activeLink: CoordinatorLink? { get set }
}
