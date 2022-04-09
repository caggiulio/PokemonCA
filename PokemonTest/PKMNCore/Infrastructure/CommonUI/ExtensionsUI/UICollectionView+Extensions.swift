//
//  UICollectionView+Extensions.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

public extension UICollectionView {
    func register(_ type: AnyClass) {
        self.register(type.self, forCellWithReuseIdentifier: type.description())
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, `for`: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.description(), for: `for`) as! T
    }
}
