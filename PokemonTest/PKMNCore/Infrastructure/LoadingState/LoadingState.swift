//
//  LoadingState.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public enum LoadingState<Value, Error: Swift.Error> {
    case idle
    /// The `Bool` indicates if is the first loading or a loading for pagination
    case loading(Bool)
    case success(Value)
    case failure(Error)
}

public extension LoadingState {
    
    var value: Value? {
        guard case .success(let value) = self else { return nil }
        return value
    }
}
