//
//  NetworkingError.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Enum for errors
public enum NetworkingError: Error {
    case invalidUrl
    case invalidHTTPResponse
    case decodingFailed(error: Error)
    case underlying(response: URLResponse?, data: Data?)
}
