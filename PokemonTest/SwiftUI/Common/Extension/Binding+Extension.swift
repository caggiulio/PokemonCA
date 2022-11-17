//
//  Binding+Extension.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 17/11/22.
//

import SwiftUI

extension Binding {
  func map<T>(get: @escaping (Value) -> T?, set: @escaping (T?) -> Value) -> Binding<T?> {
    Binding<T?>(
      get: {
        get(wrappedValue)
      },
      set: {
        wrappedValue = set($0)
      }
    )
  }
}
