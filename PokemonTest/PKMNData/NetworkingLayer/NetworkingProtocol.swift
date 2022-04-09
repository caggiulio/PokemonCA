//
//  NetworkingProtocol.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public protocol NetworkingProtocol {
  func send<SuccessResponse: Decodable>(request: NetworkingRequest, completion: ((Result<SuccessResponse, Error>) -> Void)?)
}
