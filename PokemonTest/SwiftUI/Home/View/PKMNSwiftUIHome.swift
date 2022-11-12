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
  @Injected var assembler: PKMNSwiftUIAssembler
  
  // MARK: - View
  
  var body: some View {
    PKMNBaseSwiftUIView({
      NavigationView {
        ZStack {
          Color(uiColor: AppAsset.primary.color).edgesIgnoringSafeArea(.all)
          NavigationLink(destination: assembler.detail(), isActive: $viewModel.routeToDetail, label: {})
          
          if let model = viewModel.lastValueModel {
            PKMNHomeBody(model: model.bodyModel) {
              viewModel.getNextPage()
            } pokemonDidSelect: { pokemonID in
              viewModel.setSelectedPokemon(id: pokemonID)
            }
          }
        }
      }
      .navigationViewStyle(.stack)
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

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    PKMNSwiftUIHome(viewModel: PKMNHomeSwiftUIViewModel())
  }
}
