//
//  PKMNSwiftuiDetail.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 30/10/22.
//

import SwiftUI

struct PKMNSwiftUIDetail: View {
  
  // MARK: - Stored Properties
  
  /// The `PKMNSwiftUIViewModel` of the view.
  @StateObject var viewModel: PKMNSwiftUIDetailViewModel
  
  // MARK: - View
  
    var body: some View {
      PKMNBaseSwiftUIView({
        ZStack {
          PKMNDetailBackground().edgesIgnoringSafeArea(.all)
          ScrollView {
            if let model = viewModel.lastValueModel {
              PKMNDetailHeader(pokemon: model.pokemon, overallModel: model.overallModel)
              Spacer(minLength: 30)
              PKMNDetailAbilitiesList(abilities: model.abilities)
            }
          }
          .onAppear {
            viewModel.getPokemonDetails()
          }
        }
      }, viewModel: viewModel)
    }
}

// MARK: - Private View

/// The background `View` for the view.
private struct PKMNDetailBackground: View {
  var body: some View {
    ZStack {
      LinearGradient(
        colors:
          [
            Color(uiColor: AppAsset.primary.color),
            Color(uiColor: AppAsset.secondary.color.withAlphaComponent(0.75))
          ],
        startPoint: .top,
        endPoint: .bottom
      )
    }
  }
}
