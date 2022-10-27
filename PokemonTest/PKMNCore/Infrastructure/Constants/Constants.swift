//
//  Constants.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The `enum` for the constants.
public enum PKMNConstants {
  /// The base host `URL` for all the API calls.
  public static var baseURL = "https://pokeapi.co/api/v2/"
  
  /// The main bundle of the app.
  public static func mainBundle() -> Bundle {
    return Bundle.main
  }
}
