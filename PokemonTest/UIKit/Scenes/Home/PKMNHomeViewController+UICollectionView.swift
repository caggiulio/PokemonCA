//
//  PKMNHomeViewController+UICollectionView.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 23/10/22.
//

import Foundation
import UIKit

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PKMNHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    viewModel.fetchedPokemon().count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: PKMNHomeCollectionViewCell = collectionView.dequeueReusableCell(PKMNHomeCollectionViewCell.self, for: indexPath)
    guard let pokemonItem = viewModel.pokemon(indexPath) else { return cell }
    cell.configure(pokemon: pokemonItem)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
    let width = (collectionView.frame.width) - 30
    let height = width / 2

    return .init(width: width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.isLastRow(at: collectionView) {
      viewModel.getNextPage()
    }
  }

  func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let id = viewModel.pokemon(indexPath)?.id else { return }
    viewModel.setSelectedPokemonID(id: id)
    homeCoordinator?.routeToDetail()
  }
}
