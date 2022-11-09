//
//  IndexPath+Extension.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

extension IndexPath {
  func isLastRow(at collectionView: UICollectionView) -> Bool {
    return row == (collectionView.numberOfItems(inSection: section) - 1)
  }
}
