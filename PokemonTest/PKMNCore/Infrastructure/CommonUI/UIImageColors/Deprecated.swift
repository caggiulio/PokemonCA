//
//  Deprecated.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 05.10.21.
//

#if canImport(UIKit)

  import UIKit

  @available(*, deprecated, renamed: "UIImage.Colors")
  typealias UIImageColors = UIImage.Colors

#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

  import AppKit

  @available(*, deprecated, renamed: "NSImage.Colors")
  typealias UIImageColors = NSImage.Colors

#endif

@available(*, deprecated, renamed: "ScaleQuality")
typealias UIImageColorsQuality = ScaleQuality
