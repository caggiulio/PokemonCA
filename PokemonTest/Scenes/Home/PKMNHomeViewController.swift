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

public class PKMNHomeViewController: PKMNViewController, PKMNHomeViewControllerProtocol {
  // MARK: - Business logic properties

  private var viewModel: PKMNHomeViewModelProtocol

  public weak var homeCoordinator: PKMNPokemonCoordinatorProtocol?

  var _view: PKMNHomeView? {
    guard let view = view as? PKMNHomeView else { preconditionFailure("Unable to cast view to \(PKMNHomeView.self)") }
    return view
  }

  // MARK: - Object lifecycle

  public init(viewModel: PKMNHomeViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func loadView() {
    view = PKMNHomeView()
  }

  public func loadHome() {
    viewModel.loadHome(queryItems: nil)
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    title = PKMNString.homeTitle
    setupNavigationBar()
    configureBinds()
    setDelegates()
    loadHome()
  }

  public func searchPokmemon(name: String) {
    viewModel.searchPokemon(name: name)
  }

  private func configureBinds() {
    viewModel.updateStatus = { [weak self] status in
      switch status {
        case .idle:
          self?._view?.hideLoader()
        case let .loading(isFirstLoading):
          isFirstLoading ? self?._view?.showLoader() : nil
        case .success:
          self?._view?.hideLoader()
          self?.reloadData()
        case let .failure(error):
          self?._view?.hideLoader()
          self?.handleError(error: error)
      }
    }
  }

  private func setDelegates() {
    _view?.collectionView.dataSource = self
    _view?.collectionView.delegate = self
  }

  private func reloadData() {
    DispatchQueue.main.async {
      self._view?.collectionView.reloadData()
    }
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

    homeCoordinator?.routeToDetail(pokemonID: id)
  }
}
