//
//  PKMNLocationWorker.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/11/22.
//

import CoreLocation

/// The concrete implementation of `PKMNLocationProtocol`.
class PKMNLocationWorker: NSObject, PKMNLocationProtocol, Injectable {
  // MARK: - Stored Properties
  
  /// The `CheckedContinuation` in order to make async the calls of the `CLLocationManager`.
  var locationContinuation: CheckedContinuation<CurrentLocation?, Error>?
  
  /// The `CLLocationManager` of `CoreLocation` framework.
  private var coreLocationManager: CLLocationManager
  
  // MARK: - Init
  
  /// The `init` of the `PKMNWeatherWorker`.
  /// - Parameter coreLocationManager: The `CLLocationManager` to manage `CoreLocation` APIs.
  init(coreLocationManager: CLLocationManager) {
    self.coreLocationManager = coreLocationManager
    super.init()
    self.coreLocationManager.delegate = self
  }
  
  /// Get the current location through the `CoreLocation` framework and returns the `CurrentLocation` object.
  func getCurrentLocation() async throws -> CurrentLocation? {
    try await withCheckedThrowingContinuation { continuation in
      locationContinuation = continuation
      if isLocationPermissionGranted() {
        coreLocationManager.requestLocation()
      } else {
        askLocationPermission()
      }
    }
  }
}

// MARK: - Private methods

private extension PKMNLocationWorker {
  /// Ask the location permission with `CoreLocation` framework.
  func askLocationPermission() {
    coreLocationManager.requestWhenInUseAuthorization()
  }
  
  /// Check if the location permissions are granted.
  func isLocationPermissionGranted() -> Bool {
    coreLocationManager.authorizationStatus == .authorizedWhenInUse || coreLocationManager.authorizationStatus == .authorizedAlways
  }
  
  /// Resume the `locationContinuation` with a value.
  func resume(value: CurrentLocation) {
    self.locationContinuation?.resume(returning: value)
    self.locationContinuation = nil
  }
  
  /// Resume the `locationContinuation` with an error.
  func resume(error: Error) {
    self.locationContinuation?.resume(throwing: PKMNError.genericError(error.localizedDescription))
    self.locationContinuation = nil
  }
}

// MARK: - CoreLocation Delegates

extension PKMNLocationWorker: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      resume(error: PKMNError.resourceNotFound)
      return
    }
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      if let error = error {
        self.resume(error: PKMNError.genericError(error.localizedDescription))
      }
      guard let city = placemarks?.first?.name else {
        self.resume(error: PKMNError.resourceNotFound)
        return
      }
      
      self.resume(value: CurrentLocation(coordinates: location.coordinate, cityName: city))
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      locationContinuation?.resume(throwing: error)
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
      manager.startUpdatingLocation()
    }
  }
}
