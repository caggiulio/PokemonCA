//
//  Overall.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 01/12/22.
//

import SwiftUI

/// The `View` for the single ability. Contains a `ProgressView`, a title and a value.
struct OverallView<Content: View>: View {
  // MARK: - Constants
  
  /// The minimun value for the `Gauge`.
  let minimumGaugeValue: Float = 0
  
  /// The maximum value for the `Gauge`.
  let maximumGaugeValue: Float = 1000
  
  // MARK: - Stored Properties
  
  /// The model for the `OverallView`.
  let model: OverallModel
  
  /// The view to show into the `Gauge`.
  var content: Content
  
  /// The value of the `Gauge`. Initially is `.zero` to animate the `View`.
  @State private var progress: Float = .zero
  
  // MARK: - Init
  
  /// The `init` of the `View`.
  /// - Parameters:
  ///   - content: The view to show into the `Gauge`.
  ///   - model: The model for the `OverallView`.
  init(@ViewBuilder _ content: () -> Content, model: OverallModel) {
    self.content = content()
    self.model = model
  }
  
  // MARK: - View
  
  var body: some View {
    Gauge(value: progress, in: minimumGaugeValue...maximumGaugeValue) {} currentValueLabel: {
      VStack {
        Text("\(model.title): \((model.value).formatted(.number))")
      }
    }
    .gaugeStyle(OverallGaugeStyle {
      content
    })
    .animation(.interactiveSpring(response: 1, dampingFraction: 0.8, blendDuration: 0.8), value: progress)
    .onAppear {
      Task {
        do {
          try await Task.sleep(for: .seconds(0.5))
          progress = model.value
        } catch {}
      }
    }
  }
}
