//
//  PKMNMainCoordinator.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

class PKMNMainCoordinator: Coordinator {
  var childrenCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var parentCoordinator: Coordinator?

  // MARK: - Repositories container

  var container: PKMNMainContainerProtocol
  var pokemonCoordinator: PKMNPokemonCoordinatorProtocol

  init(navigationController: UINavigationController, mainContainer: PKMNMainContainerProtocol) {
    container = mainContainer
    self.navigationController = navigationController

    pokemonCoordinator = PKMNPokemonCoordinator(navigationController: navigationController, mainContainer: mainContainer)
    pokemonCoordinator.parentCoordinator = self
    childrenCoordinators.append(pokemonCoordinator)
  }

  // MARK: - Start

  /// The start of MainCoordinator. In this func there is the dirst view controller of app
  func start(context: Any?) {
    pokemonCoordinator.start(context: context)
  }
}
