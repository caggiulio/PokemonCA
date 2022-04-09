//
//  PKMNHomeViewController+UISearchBar.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Foundation
import UIKit

extension PKMNHomeViewController: UISearchBarDelegate {
  func setupNavigationBar() {
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController

    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = PKMNString.standardSearch
    searchController.searchBar.barTintColor = PKMNThemeManager.currentTheme().primaryColor
    searchController.searchBar.searchBarStyle = .minimal
    searchController.searchBar.returnKeyType = .done
    searchController.searchBar.tintColor = PKMNThemeManager.currentTheme().tertiaryColor

    searchController.obscuresBackgroundDuringPresentation = false
    searchController.definesPresentationContext = true
    searchController.searchBar.showsCancelButton = false
    searchController.hidesNavigationBarDuringPresentation = false

    if #available(iOS 13.0, *) {
      searchController.searchBar.searchTextField.font = PKMNThemeManager.currentTheme().primaryFont.font(size: 15)
    }
  }

  public func searchBar(_: UISearchBar, textDidChange searchText: String) {
    searchPokmemon(name: searchText)
  }

  public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}
