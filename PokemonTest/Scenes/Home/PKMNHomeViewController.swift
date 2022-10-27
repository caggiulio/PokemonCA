//
//  PKMNHomeViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

// MARK: - PKMNHomeViewControllerProtocol

public protocol PKMNHomeViewControllerProtocol {
  func loadHome()
  func searchPokmemon(name: String)
}

// MARK: - PKMNHomeViewController

public class PKMNHomeViewController: PKMNViewController<Empty, PKMNHomeView, PKMNHomeViewModel>, PKMNHomeViewControllerProtocol {
  // MARK: - Business logic properties

  public weak var homeCoordinator: PKMNPokemonCoordinatorProtocol?
  
  override public func viewDidLoad() {
    super.viewDidLoad()

    title = PKMNString.homeTitle
    setupNavigationBar()
    setDelegates()
    loadHome()
  }
  
  // MARK: - Methods
  
  public func loadHome() {
    viewModel.loadHome(queryItems: nil)
  }

  public func searchPokmemon(name: String) {
    viewModel.searchPokemon(name: name)
  }

  private func setDelegates() {
    rootView.collectionView.dataSource = self
    rootView.collectionView.delegate = self
  }
}
