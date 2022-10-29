//
//  PKMNAppAssets.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

typealias AssetAppImageTypeAlias = ImageAppAsset.ImageApp

// MARK: - AppAsset

enum AppAsset {
  // MARK: - Colors

  static let primary = ColorAppAsset(name: "Primary")
  static let secondary = ColorAppAsset(name: "Secondary")
  static let tertiary = ColorAppAsset(name: "Tertiary")
  static let background = ColorAppAsset(name: "Background")

  // MARK: - Images

  static let pokeball = ImageAppAsset(name: "pokeball")
}

// MARK: - ColorAppAsset

final class ColorAppAsset {
  fileprivate(set) var name: String
  typealias ColorApp = UIColor

  private(set) lazy var color: ColorApp = {
    guard let color = ColorApp(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

extension ColorAppAsset.ColorApp {
  convenience init?(asset: ColorAppAsset) {
    let bundle = PKMNConstants.mainBundle()
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
  }
}

// MARK: - ImageAppAsset

struct ImageAppAsset {
  fileprivate(set) var name: String
  typealias ImageApp = UIImage

  var image: ImageApp {
    let bundle = PKMNConstants.mainBundle()
    let image = ImageApp(named: name, in: bundle, compatibleWith: nil)
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

extension ImageAppAsset.ImageApp {
  convenience init?(asset: ImageAppAsset) {
    let bundle = PKMNConstants.mainBundle()
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
  }
}
