//
//  Main.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

/// The `View` for the home.
struct PKMNSwiftUIHome: View {
  // MARK: - Stored Properties
  
  /// The `PKMNSwiftUIViewModel` of the view.
  @StateObject var viewModel: PKMNHomeSwiftUIViewModel
  
  /// The searchable `DebounceObject` to search the `Pokemon`.
  @StateObject var debounceString = DebounceStringObject()
  
  // MARK: - Computed Properties
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  var assembler: PKMNSwiftUIAssembler
  
  // MARK: - View
  
  var body: some View {
    PKMNBaseSwiftUIView({
      NavigationView {
        if let model = viewModel.lastValueModel {
          PKMNHomeBody(model: model.bodyModel, assembler: assembler) {
            viewModel.getNextPage()
          }
        }
      }
      .searchable(text: $debounceString.text)
      .onChange(of: debounceString.debouncedText) { text in
        viewModel.searchByName(name: text)
      }
      .onAppear {
        viewModel.loadHome(queryItems: nil)
      }
    }, viewModel: viewModel)
  }
}
