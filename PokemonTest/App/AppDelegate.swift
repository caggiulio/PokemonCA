//
//  AppDelegate.swift
//  PokemonTest
//
//  Created on 23/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var mainCoordinator: PKMNMainCoordinator?
  var window: UIWindow?
  let mainContainer: PKMNMainContainerProtocol = PKMNMainContainer()

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setup()

    return true
  }

  private func setup() {
    let mainTheme = PKMNTheme(primaryFont: .init(stringLiteral: "Lato-Regular"), primaryBoldFont: .init(stringLiteral: "Lato-Black"), primaryMediumFont: .init(stringLiteral: "Lato-Bold"), primaryItalicFont: .init(stringLiteral: "Lato-Italic"))
    PKMNThemeManager.applyTheme(theme: mainTheme)

    let appWindow = UIWindow(frame: UIScreen.main.bounds)
    mainCoordinator = PKMNMainCoordinator(navigationController: UINavigationController(), mainContainer: mainContainer)
    mainCoordinator?.start()
    appWindow.rootViewController = mainCoordinator?.navigationController
    appWindow.makeKeyAndVisible()
    window = appWindow

    /// Setup Inject
    #if DEBUG
      Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
      // for tvOS:
      Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle")?.load()
      // Or for macOS:
      Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle")?.load()
    #endif
  }
}
