//
//  PKMNAppAssets.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import Foundation
import UIKit

public typealias AssetAppImageTypeAlias = ImageAppAsset.ImageApp

public enum AppAsset {
    // MARK: - Colors
    public static let primary = ColorAppAsset(name: "Primary")
    public static let secondary = ColorAppAsset(name: "Secondary")
    public static let tertiary = ColorAppAsset(name: "Tertiary")
    public static let background = ColorAppAsset(name: "Background")
    
    // MARK: - Images
    public static let pokeball = ImageAppAsset(name: "pokeball")
}

public final class ColorAppAsset {
    public fileprivate(set) var name: String
    public typealias ColorApp = UIColor
    
    public private(set) lazy var color: ColorApp = {
        guard let color = ColorApp(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()

    fileprivate init(name: String) {
        self.name = name
    }
}

public extension ColorAppAsset.ColorApp {
    convenience init?(asset: ColorAppAsset) {
        let bundle = PKMNDataBundleResolver.returnMainBundle()
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
    }
}

public struct ImageAppAsset {
    public fileprivate(set) var name: String
    public typealias ImageApp = UIImage

    public var image: ImageApp {
        let bundle = PKMNDataBundleResolver.returnMainBundle()
        let image = ImageApp(named: name, in: bundle, compatibleWith: nil)
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }
}

public extension ImageAppAsset.ImageApp {
    convenience init?(asset: ImageAppAsset) {
        let bundle = PKMNDataBundleResolver.returnMainBundle()
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
    }
}

