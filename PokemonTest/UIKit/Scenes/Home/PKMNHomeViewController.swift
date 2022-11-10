//
//  PKMNHomeViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

// MARK: - PKMNHomeViewControllerProtocol

protocol PKMNHomeViewControllerProtocol {
  func loadHome()
  func searchPokmemon(name: String)
}

// MARK: - PKMNHomeViewController

class PKMNHomeViewController: PKMNViewController<Empty, PKMNHomeView, PKMNHomeViewModel>, PKMNHomeViewControllerProtocol {
  // MARK: - Business logic properties

  weak var homeCoordinator: PKMNPokemonCoordinatorProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = PKMNString.homeTitle
    setupNavigationBar()
    setDelegates()
    loadHome()
  }
  
  // MARK: - Methods
  
  func loadHome() {
    viewModel.loadHome(queryItems: nil)
  }

  func searchPokmemon(name: String) {
    viewModel.searchPokemon(name: name)
  }

  private func setDelegates() {
    rootView.collectionView.dataSource = self
    rootView.collectionView.delegate = self
  }
}
