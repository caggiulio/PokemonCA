//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import AloyNetworking

public struct PKMNNetworkingManager {
  private let networking: AloyNetworkingProtocol = {
    let networking = AloyNetworking(
      baseURL: PKMNConstants.baseURL, cachePolicy: .returnCacheDataElseLoad
    )
    return networking
  }()

  /// This is the implementation of `PKMNNetworkingDataSourceProtocol`
  public var networkingDataSource: PKMNNetworkingDataSourceProtocol

  init() {
    networkingDataSource = PKMNNetworkingDataSourceWorker(networking: networking)
  }
}
