//
//  PKMNPokemonCoordinator.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/01/22.
//

import Foundation
import UIKit

// MARK: - PKMNPokemonCoordinatorProtocol

protocol PKMNPokemonCoordinatorProtocol: Coordinator {
  func routeToDetail(id: String)
}

// MARK: - PKMNPokemonCoordinator

class PKMNPokemonCoordinator: PKMNPokemonCoordinatorProtocol {
  var childrenCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var parentCoordinator: Coordinator?

  // MARK: - Repositories container

  var container: PKMNMainContainerProtocol

  init(navigationController: UINavigationController, mainContainer: PKMNMainContainerProtocol) {
    container = mainContainer
    self.navigationController = navigationController
  }

  // MARK: - Start

  /// The start of MainCoordinator. In this func there is the dirst view controller of app
  func start(context: Any?) {
    let pkmnViewController: PKMNHomeViewController = PKMNHomeAssembler(container: container).resolve()
    pkmnViewController.homeCoordinator = self
    
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.pushViewController(pkmnViewController, animated: false)
  }
  
  func routeToDetail(id: String) {
    let pkmnDetailViewController: PKMNDetailViewController = PKMNDetailAssembler(container: container, id: id).resolve()
    pkmnDetailViewController.detailCoordinator = self

    navigationController.present(pkmnDetailViewController, animated: true, completion: nil)
  }
}
