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
  let viewModel: PKMNSwiftUIDetailViewModel
  
  // MARK: - Computed Properties
  
  /// The `PKMNModel` handeld by the `View`.
  @State private var model: PKMNDetailModel?
  
  // MARK: - View
  
    var body: some View {
      VStack {
        if let model = model {
          header(model: model)
          list(model: model)
        }
      }
      .frame(maxWidth: .infinity)
      .background(Color(uiColor: AppAsset.primary.color))
      .onAppear {
        viewModel.getPokemonDetails()
      }
      .handleLoadingState(state: viewModel.$loadingState) { model in
        self.model = model
      }
    }
}

// MARK: - Private View

private extension PKMNSwiftUIDetail {
  /// This func builds the header of the `View`.
  /// - Parameter model: the `PKMNModel` handeld by the `View`.
  func header(model: PKMNDetailModel) -> some View {
    VStack {
      Text(model.pokemon.name.capitalized)
        .fontWeight(.bold)
        .font(.title)
        .foregroundColor(Color(uiColor: AppAsset.background.color))
      ZStack {
        Image(uiImage: AppAsset.pokeball.image)
          .resizable()
          .frame(width: 250, height: 250)
          .foregroundColor(Color(uiColor: AppAsset.tertiary.color))
        
        AsyncImage(url: URL(string: model.pokemon.frontImage.stringURL)) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .frame(width: 185, height: 185)
            
          default:
            Image(uiImage: AppAsset.pokeball.image)
          }
        }
      }
      .frame(height: 200)
    }
  }
  
  /// This func builds the list of the abilities for the `View`.
  /// - Parameter model: the `PKMNModel` handeld by the `View`.
  func list(model: PKMNDetailModel) -> some View {
    VStack {
      ScrollView {
        ForEach(model.abilities) { ability in
          AbilityView(model: ability)
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(uiColor: AppAsset.tertiary.color))
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}
