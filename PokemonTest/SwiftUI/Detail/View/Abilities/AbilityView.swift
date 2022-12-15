//
//  AbilityView.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 31/10/22.
//

import SwiftUI

/// The `View` for the single ability. Contains a `ProgressView`, a title and a value.
struct AbilityView: View {
  // MARK: - Constants
  
  /// The minimun value for the `Gauge`.
  let minimumGaugeValue: Float = 0
  
  /// The maximum value for the `Gauge`.
  let maximumGaugeValue: Float = 120
  
  // MARK: - Stored Properties
  
  /// The model for the single `Ability`.
  let model: AbilityModel
  
  /// The value of the `ProgressView`. Initially is `.zero` to animate the `View`.
  @State private var progress: Float = .zero
  
  /// The `LinearGradient` used to style the gauge.
  private var gradient = LinearGradient(
    colors:
      [
        Color(uiColor: AppAsset.primary.color),
        Color(uiColor: AppAsset.background.color)
      ],
    startPoint: .trailing,
    endPoint: .leading
  )
  
  // MARK: - Init
  
  /// The `init` of the `View`.
  /// - Parameter model: The model for the single `Ability`.
  init(model: AbilityModel) {
    self.model = model
  }
  
  // MARK: - View
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(model.title)
        .fontWeight(.bold)
        .font(.title3)
        .foregroundColor(Color(uiColor: AppAsset.secondary.color))
      
      Gauge(value: progress, in: minimumGaugeValue...maximumGaugeValue) {}
        .animation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8), value: progress)
    }
    .tint(Color(AppAsset.primary.color))
    .padding()
    .onAppear {
      Task {
        do {
          try await Task.sleep(nanoseconds: 1_000_000_000)
          progress = model.baseValue
        } catch {}
      }
    }
  }
}

struct AbilityView_Previews: PreviewProvider {
  static var previews: some View {
    AbilityView(model: .init(title: "Stat Name", baseValue: 100, percentValue: 0.83))
  }
}
