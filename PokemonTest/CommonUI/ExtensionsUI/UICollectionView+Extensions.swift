//
//  UICollectionView+Extensions.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

extension UICollectionView {
  func register(_ type: AnyClass) {
    register(type.self, forCellWithReuseIdentifier: type.description())
  }

  func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: type.description(), for: `for`) as! T
  }
}
