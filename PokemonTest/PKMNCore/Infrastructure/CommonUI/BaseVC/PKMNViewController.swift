//
//  PKMNViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import UIKit

public class PKMNViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        self.navigationController?.view.backgroundColor = PKMNThemeManager.currentTheme().navigationBarBackgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
