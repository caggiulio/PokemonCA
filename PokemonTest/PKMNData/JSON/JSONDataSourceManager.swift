//
//  JSONDataSourceManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The JSON manager.
public struct JSONDataSourceManager {
  public init() {}

  /// The datasource for JSON. It's a concrete instance of `JSONDataSourceProtocol`.
  public let jsonDataSource: JSONDataSourceProtocol = JSONDataSourceWorker()
}
