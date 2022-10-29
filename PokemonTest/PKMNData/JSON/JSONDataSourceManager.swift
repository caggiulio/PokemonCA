//
//  JSONDataSourceManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// The JSON manager.
struct JSONDataSourceManager {
  init() {}

  /// The datasource for JSON. It's a concrete instance of `JSONDataSourceProtocol`.
  let jsonDataSource: JSONDataSourceProtocol = JSONDataSourceWorker()
}
