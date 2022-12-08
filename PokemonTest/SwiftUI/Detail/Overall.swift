//
//  Overall.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 01/12/22.
//

import SwiftUI

/// The `View` for the single ability. Contains a `ProgressView`, a title and a value.
struct OverallView<Content: View>: View {
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
    Gauge(value: progress) {
      EmptyView()
    } currentValueLabel: {
      VStack {
        Text("\(model.title): \((model.value * 100).formatted(.number))")
      }
    }
    .gaugeStyle(OverallGaugeStyle {
      content
    })
    .tint(Color(uiColor: AppAsset.primary.color))
    .animation(.interactiveSpring(response: 1, dampingFraction: 0.8, blendDuration: 0.8), value: progress)
    .onAppear {
      Task {
        do {
          try await Task.sleep(nanoseconds: 500_000_000)
          progress = model.value
        } catch {}
      }
    }
  }
}
