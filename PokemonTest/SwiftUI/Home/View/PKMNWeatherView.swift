//
//  PKMNWeatherView.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/11/22.
//

import SwiftUI

/// The `View` for the current weather information.
struct PKMNWeatherInformation: View {
  // MARK: - Stored Properties
  
  /// The model of the `View`.
  private let model: PKMNHomeWeatherModel
  
  // MARK: - Init
  
  /// The init of the `View`.
  /// - Parameter model:  the model handeld by the `View`.
  ///   - model: the model handeld by the `View`.
  init(model: PKMNHomeWeatherModel) {
    self.model = model
  }
  
  // MARK: - Body
  
  var body: some View {
    HStack(spacing: 15) {
      model.icon
        .resizable()
        .frame(width: 50, height: 50)
        .foregroundColor(Color(uiColor: AppAsset.tertiary.color))
      
      Text(model.title)
        .fontWeight(.semibold)
        .font(.body)
        .foregroundColor(Color(uiColor: AppAsset.tertiary.color))
    }
    .padding(.all)
    .background {
      LinearGradient(
        colors:
          [
            Color(uiColor: AppAsset.secondary.color),
            Color.clear
          ],
        startPoint: .top,
        endPoint: .bottom
      )
    }
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}

struct Weather_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      PKMNWeatherInformation(model: PKMNHomeWeatherModel(title: "È un grande giorno per catturare Pokemon. La temperatura è di 20º e le condizioni sono soleggiate.", icon: Image(systemName: "sun.max")))
    }
    .background {
      Color(uiColor: AppAsset.primary.color)
    }
  }
}

