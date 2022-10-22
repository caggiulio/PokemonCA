//
//  PKMNPokemonCoordinator.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/01/22.
//

import Foundation
import UIKit

// MARK: - PKMNPokemonCoordinatorProtocol

public protocol PKMNPokemonCoordinatorProtocol: Coordinator {}

// MARK: - PKMNPokemonCoordinator

public class PKMNPokemonCoordinator: PKMNPokemonCoordinatorProtocol {
  public var childrenCoordinators = [Coordinator]()
  public var navigationController: UINavigationController
  public var parentCoordinator: Coordinator?

  // MARK: - Repositories container

  var container: PKMNMainContainerProtocol

  public init(navigationController: UINavigationController, mainContainer: PKMNMainContainerProtocol) {
    container = mainContainer
    self.navigationController = navigationController
  }

  // MARK: - Start

  /// The start of MainCoordinator. In this func there is the dirst view controller of app
  public func start(context: Any?) {
    guard let id = context as? String else {
      return
    }
    
    let pkmnDetailViewController: PKMNDetailViewController = PKMNDetailAssembler(container: container, id: id).resolve()
    pkmnDetailViewController.detailCoordinator = self

    navigationController.present(pkmnDetailViewController, animated: true, completion: nil)
  }
}
