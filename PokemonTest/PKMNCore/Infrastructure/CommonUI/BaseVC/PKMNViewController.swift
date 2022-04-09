//
//  PKMNViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import UIKit

public class PKMNViewController: UIViewController {
  override public func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  private func setup() {
    navigationController?.view.backgroundColor = PKMNThemeManager.currentTheme().navigationBarBackgroundColor
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
