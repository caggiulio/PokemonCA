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

public class PKMNDetailViewController: PKMNViewController<PKMNDetailView, PKMNDetailViewModel>, PMKNDetailViewControllerProtocol {
  // MARK: - Business logic properties

  public weak var detailCoordinator: PKMNPokemonCoordinator?

  // MARK: - Object lifecycle

  public override init(viewModel: PKMNDetailViewModel) {
    super.init(viewModel: viewModel)
  }

  public func loadPokemon() {
    viewModel.loadPokemon()
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    configureBinds()
    loadPokemon()
  }

  private func configureBinds() {
    viewModel.updateStatus = { [weak self] status in
      self?.handle(status, success: { pokemon in
        self?._view.configure(pokemon: pokemon)
      })
    }
  }
}
