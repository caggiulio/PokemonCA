//
//  PMKNDetailViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

// MARK: - PMKNDetailViewControllerProtocol

protocol PMKNDetailViewControllerProtocol {
  func loadPokemon()
}

// MARK: - PKMNDetailViewController

class PKMNDetailViewController: PKMNViewController<Pokemon, PKMNDetailView, PKMNDetailViewModel>, PMKNDetailViewControllerProtocol {
  // MARK: - Business logic properties

  weak var detailCoordinator: PKMNPokemonCoordinator?

  override func viewDidLoad() {
    super.viewDidLoad()

    loadPokemon()
  }
  
  // MARK: - Methods
  
  func loadPokemon() {
    viewModel.loadPokemon()
  }
}
