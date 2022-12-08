//
//  OverallGaugeStyle.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 02/12/22.
//

import SwiftUI

/// The `GaugeStyle` of the `OverallView`.
struct OverallGaugeStyle<Content: View>: GaugeStyle {
  // MARK: - Stored Properties
  
  /// The `View` contained by the gauge.
  var content: Content
  
  /// The `LinearGradient` used to style the gauge.
  private var gradient = LinearGradient(
    colors:
      [
        Color(uiColor: AppAsset.background.color.withAlphaComponent(0.5)),
        Color(uiColor: AppAsset.primary.color)
      ],
    startPoint: .trailing,
    endPoint: .leading
  )
  
  // MARK: - Init
  
  /// The `init` of the `OverallGaugeStyle`.
  /// - Parameter content: The `View` contained by the gauge.
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  func makeBody(configuration: Configuration) -> some View {
    VStack {
      ZStack {
        content
        Circle()
          .trim(from: 0, to: configuration.value)
          .stroke(gradient, style: StrokeStyle(lineWidth: 20, lineCap: .round))
          .rotationEffect(.degrees(180))
          .frame(width: 250, height: 250)
      }
      
      configuration.currentValueLabel
        .fontWeight(.bold)
        .font(.title2)
        .foregroundColor(Color(uiColor: AppAsset.background.color))
    }
  }
}
