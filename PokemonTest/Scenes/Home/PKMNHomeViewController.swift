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

  // MARK: - Object lifecycle

  public override init(viewModel: PKMNHomeViewModel) {
    super.init(viewModel: viewModel)
  }
  
  public func loadHome() {
    viewModel.loadHome(queryItems: nil)
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    title = PKMNString.homeTitle
    setupNavigationBar()
    setDelegates()
    loadHome()
  }

  public func searchPokmemon(name: String) {
    viewModel.searchPokemon(name: name)
  }

  private func setDelegates() {
    rootView.collectionView.dataSource = self
    rootView.collectionView.delegate = self
  }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PKMNHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    viewModel.retrievedPokemon().count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: PKMNHomeCollectionViewCell = collectionView.dequeueReusableCell(PKMNHomeCollectionViewCell.self, for: indexPath)
    guard let pokemonItem = viewModel.pokemon(indexPath) else { return cell }
    cell.configure(pokemon: pokemonItem)

    return cell
  }

  public func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
    let width = (collectionView.frame.width) - 30
    let height = width / 2

    return .init(width: width, height: height)
  }

  public func collectionView(_ collectionView: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.isLastRow(at: collectionView) {
      viewModel.getNextPage()
    }
  }

  public func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let id = viewModel.pokemon(indexPath)?.id else { return }

    homeCoordinator?.start(context: id)
  }
}
