//
//  PMKNDetailViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

// MARK: - PMKNDetailViewControllerProtocol

public protocol PMKNDetailViewControllerProtocol {
  func loadPokemon()
}

// MARK: - PKMNDetailViewController

public class PKMNDetailViewController: PKMNViewController<Pokemon, PKMNDetailView, PKMNDetailViewModel>, PMKNDetailViewControllerProtocol {
  // MARK: - Business logic properties

  public weak var detailCoordinator: PKMNPokemonCoordinator?

  // MARK: - Object lifecycle

  public override init(viewModel: PKMNDetailViewModel) {
    super.init(viewModel: viewModel)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()

    loadPokemon()
  }
  
  // MARK: - Methods
  
  public func loadPokemon() {
    viewModel.loadPokemon()
  }
}
