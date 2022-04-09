//
//  Coordinator.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var childrenCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func end()
    func destroyChildren(completion: (() -> ())?)
}

public extension Coordinator {
    /// The func `end()` dismiss all coordinator, included that of the `parentCoordinator`, if exist.
    func end() {
        self.childrenCoordinators.removeAll()
        self.navigationController.dismiss(animated: true, completion: nil)
        self.parentCoordinator?.end()
    }
    
    /// This func dismiss all children coordinator
    func destroyChildren(completion: (() -> ())?) {
        for child in childrenCoordinators {
            DispatchQueue.main.async {
                child.navigationController.dismiss(animated: true, completion: completion)
            }
        }
    }
}
