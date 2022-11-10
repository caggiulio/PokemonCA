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
  func routeToDetail()
}

// MARK: - PKMNPokemonCoordinator

class PKMNPokemonCoordinator: PKMNPokemonCoordinatorProtocol {
  var childrenCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var parentCoordinator: Coordinator?
  private var assembler: PKMNAssembler = PKMNAssembler()

  // MARK: - Repositories container

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Start

  /// The start of MainCoordinator. In this func there is the dirst view controller of app
  func start(context: Any?) {
    let pkmnViewController: PKMNHomeViewController = assembler.home()
    pkmnViewController.homeCoordinator = self
    
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.pushViewController(pkmnViewController, animated: false)
  }
  
  func routeToDetail() {
    let pkmnDetailViewController: PKMNDetailViewController = assembler.detail()
    pkmnDetailViewController.detailCoordinator = self

    navigationController.present(pkmnDetailViewController, animated: true, completion: nil)
  }
}
