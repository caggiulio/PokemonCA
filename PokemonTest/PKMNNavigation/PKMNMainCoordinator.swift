//
//  PKMNMainCoordinator.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

public class PKMNMainCoordinator: Coordinator {
  public var childrenCoordinators = [Coordinator]()
  public var navigationController: UINavigationController
  public var parentCoordinator: Coordinator?

  // MARK: - Repositories container

  var container: PKMNMainContainerProtocol
  var pokemonCoordinator: PKMNPokemonCoordinatorProtocol

  public init(navigationController: UINavigationController, mainContainer: PKMNMainContainerProtocol) {
    container = mainContainer
    self.navigationController = navigationController

    pokemonCoordinator = PKMNPokemonCoordinator(navigationController: navigationController, mainContainer: mainContainer)
    pokemonCoordinator.parentCoordinator = self
    childrenCoordinators.append(pokemonCoordinator)
  }

  // MARK: - Start

  /// The start of MainCoordinator. In this func there is the dirst view controller of app
  public func start(context: Any?) {
    /// Istantiate initial view controller
    let pkmnViewController: PKMNHomeViewController = PKMNHomeAssembler(container: container).resolve()
    pkmnViewController.homeCoordinator = pokemonCoordinator
    
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.pushViewController(pkmnViewController, animated: false)
  }
}
