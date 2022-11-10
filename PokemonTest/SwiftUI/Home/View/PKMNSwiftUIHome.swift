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
  @Inject var assembler: PKMNSwiftUIAssembler
  
  /// The `Bool` used to navigate to the detail.
  @State var routeToDetail: Bool = false
  
  // MARK: - View
  
  var body: some View {
    PKMNBaseSwiftUIView({
      NavigationView {
        ZStack {
          Color(uiColor: AppAsset.primary.color).edgesIgnoringSafeArea(.all)
          NavigationLink(destination: assembler.detail(), isActive: $routeToDetail, label: {})
          
          if let model = viewModel.lastValueModel {
            PKMNHomeBody(model: model.bodyModel) {
              viewModel.getNextPage()
            } pokemonDidSelect: { pokemonID in
              viewModel.setSelectedPokemon(id: pokemonID)
              routeToDetail.toggle()
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
