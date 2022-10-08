//
//  PKMNHomeView.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Anchorage
import Foundation
import UIKit

public class PKMNHomeView: PKMNView<Any> {
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

  override init(frame: CGRect) {
    super.init(frame: frame)

    configureUI()
    configureConstraints()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureUI() {
    backgroundColor = PKMNThemeManager.currentTheme().backgroundColor

    addSubview(collectionView)
    collectionView.setCollectionViewLayout(layout, animated: false)
  }

  private func configureConstraints() {
    collectionView.leadingAnchor /==/ leadingAnchor
    collectionView.trailingAnchor /==/ trailingAnchor
    collectionView.topAnchor /==/ safeAreaLayoutGuide.topAnchor
    collectionView.bottomAnchor /==/ safeAreaLayoutGuide.bottomAnchor
  }
  
  override func update(model: Any?) {
    if let _ = model {
      collectionView.reloadData()
    }
  }
}
