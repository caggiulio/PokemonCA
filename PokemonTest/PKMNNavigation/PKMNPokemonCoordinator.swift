//
//  PKMNPokemonCoordinator.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/01/22.
//

import Foundation
import UIKit
import Inject

public protocol PKMNPokemonCoordinatorProtocol: Coordinator {
    func routeToDetail(pokemonID: String)
}

public class PKMNPokemonCoordinator: PKMNPokemonCoordinatorProtocol {
    
    public var childrenCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator? = nil
    
    //MARK: - Repositories container
    var container: PKMNMainContainerProtocol
    
    public init(navigationController: UINavigationController, mainContainer: PKMNMainContainerProtocol) {
        self.container = mainContainer
        self.navigationController = navigationController
    }

    //MARK: - Start
    /// The start of MainCoordinator. In this func there is the dirst view controller of app
    public func start() {
        /// Istantiate initial view controller
        let pkmnViewController: _InjectableViewControllerHost<PKMNHomeViewController> = PKMNHomeAssembler(container: container).resolve()
        pkmnViewController.homeCoordinator = self
    
        navigationController.pushViewController(pkmnViewController, animated: false)
    }
    
    public func routeToDetail(pokemonID: String) {
        let pkmnDetailViewController: _InjectableViewControllerHost<PKMNDetailViewController> = PKMNDetailAssembler(container: container, id: pokemonID).resolve()
        
        navigationController.present(pkmnDetailViewController, animated: true, completion: nil)
    }
}
