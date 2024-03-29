//
//  AppDelegate.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import UIKit

//@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var mainCoordinator: PKMNMainCoordinator?
  var window: UIWindow?
  private let manager = DependencyManager()

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setup()

    return true
  }

  private func setup() {
    let mainTheme = PKMNTheme(primaryFont: .init(stringLiteral: "Lato-Regular"), primaryBoldFont: .init(stringLiteral: "Lato-Black"), primaryMediumFont: .init(stringLiteral: "Lato-Bold"), primaryItalicFont: .init(stringLiteral: "Lato-Italic"))
    PKMNThemeManager.applyTheme(theme: mainTheme)

    let appWindow = UIWindow(frame: UIScreen.main.bounds)
    mainCoordinator = PKMNMainCoordinator(navigationController: UINavigationController())
    mainCoordinator?.start(context: nil)
    appWindow.rootViewController = mainCoordinator?.navigationController
    appWindow.makeKeyAndVisible()
    window = appWindow
  }
}
