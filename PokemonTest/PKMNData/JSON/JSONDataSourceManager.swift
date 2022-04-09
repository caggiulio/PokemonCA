//
//  JSONDataSourceManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct JSONDataSourceManager {
    
    public init() {}

    public let jsonDataSource: JSONDataSourceProtocol = {
        return JSONDataSourceWorker()
    }()
    
}
