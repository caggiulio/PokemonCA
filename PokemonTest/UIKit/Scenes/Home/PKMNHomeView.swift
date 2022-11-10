//
//  PKMNHomeView.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Anchorage
import Foundation
import UIKit

class PKMNHomeView: PKMNView<Empty> {
  var collectionView: UICollectionView = {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    collectionView.backgroundColor = PKMNThemeManager.currentTheme().backgroundColor
    collectionView.register(PKMNHomeCollectionViewCell.self)
    collectionView.keyboardDismissMode = .onDrag

    return collectionView
  }()

  private var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 15
    layout.minimumLineSpacing = 15
    layout.scrollDirection = .vertical
    layout.sectionInset = .init(top: 16, left: 15, bottom: 16, right: 15)

    return layout
  }()

  override func configureUI() {
    backgroundColor = PKMNThemeManager.currentTheme().backgroundColor

    addSubview(collectionView)
    collectionView.setCollectionViewLayout(layout, animated: false)
  }

  override func configureConstraints() {
    collectionView.leadingAnchor /==/ leadingAnchor
    collectionView.trailingAnchor /==/ trailingAnchor
    collectionView.topAnchor /==/ safeAreaLayoutGuide.topAnchor
    collectionView.bottomAnchor /==/ safeAreaLayoutGuide.bottomAnchor
  }
  
  override func update(model: Empty?) {
    collectionView.reloadData()
  }
}
