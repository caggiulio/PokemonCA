//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import AloyNetworking
 
/// The manager for the networking workers.
struct PKMNNetworkingManager {
  /// The concrete implementation of `AloyNetworkingProtocol`.
  private let networking: AloyNetworkingProtocol = {
    let networking = AloyNetworking(
      baseURL: PKMNConstants.baseURL, cachePolicy: .returnCacheDataElseLoad
    )
    return networking
  }()

  /// This is the implementation of `PKMNNetworkingDataSourceProtocol`
  var networkingDataSource: PKMNNetworkingDataSourceProtocol

  init() {
    networkingDataSource = PKMNNetworkingDataSourceWorker(networking: networking)
  }
}
