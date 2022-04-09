//
//  PKMNError.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public enum PKMNError: Swift.Error, Equatable {
    case genericError(String)
    case resourceNotFound
}

extension PKMNError: LocalizedError {
    /// We must override `errorDescription` to access `error.localizedDescription`
    
    public var errorDescription: String? {
        switch self {
        case .genericError(let message):
            return message
        case .resourceNotFound:
            return PKMNString.resourceNotFound
        }
    }
}
