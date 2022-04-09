//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct PKMNNetworkingManager {
    
    private let networking: NetworkingProtocol = {
        let networking = Networking(
            baseURL: PKMNConstants.baseURL, cachePolicy: .returnCacheDataElseLoad)
        return networking
    }()

    /// This is the implementation of `PKMNNetworkingDataSourceProtocol`
    public var networkingDataSource: PKMNNetworkingDataSourceProtocol
    
    init() {
        networkingDataSource = PKMNNetworkingDataSourceWorker(networking: networking)
    }
}
