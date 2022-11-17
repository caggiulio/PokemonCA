//
//  CoordinatorLink.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 17/11/22.
//

import Foundation

/// The enums that defines the possible destination links of the flow.
enum CoordinatorLink: Hashable, Identifiable {
  case home
  case detail
  case detailSheet
  
  // MARK: - Computed Properties
  
  /// The `CoordinatorLink` used in the `ViewModel`.
  var navigationLink: CoordinatorLink {
    switch self {
    case .home:
      return .home
      
    case .detail:
      return .detail
      
    case .detailSheet:
      return .detailSheet
    }
  }
  
  /// The `CoordinatorLink` used in the `ViewModel` for the bottom sheet.
  var sheetItem: CoordinatorLink? {
      switch self {
      case .detailSheet:
          return self
        
      default:
          return nil
      }
  }
  
  /// The `CoordinatorLink` id as `String` . Is the reflecting string of the `View` struct.
  var id: String {
    switch self {
    case .home:
      return String(reflecting: PKMNSwiftUIHome.self)
      
    case .detail:
      return String(reflecting: PKMNSwiftUIDetail.self)
      
    case .detailSheet:
      return String(reflecting: PKMNSwiftUIDetail.self)
    }
  }
}
