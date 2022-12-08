//
//  PKMNLocationManager.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/11/22.
//

import CoreLocation

/// The manager for the location workers.
struct PKMNLocationManager: Injectable {
  /// The Apple location manager.
  private let coreLocationManager: CLLocationManager = {
    CLLocationManager()
  }()
  
  /// The concrete implementation of `PKMNLocationProtocol`.
  var locationWorker: PKMNLocationProtocol

  init() {
    locationWorker = PKMNLocationWorker(coreLocationManager: coreLocationManager)
  }
}
