//
//  AbilityView.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 31/10/22.
//

import SwiftUI

/// The `View` for the single ability. Contains a `ProgressView`, a title and a value.
struct AbilityView: View {
  // MARK: - Stored Properties
  
  /// The model for the single `Ability`.
  let model: AbilityModel
  
  /// The value of the `ProgressView`. Initially is `.zero` to animate the `View`.
  @State private var progress: Float = .zero
  
  // MARK: - View
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(model.title)
        .fontWeight(.bold)
        .font(.title3)
      HStack {
        ProgressView(value: progress)
          .animation(.easeInOut(duration: 1), value: progress)
          .progressViewStyle(.linear)
          .tint(Color(uiColor: AppAsset.primary.color))
          .scaleEffect(x: 1, y: 1.75, anchor: .center)
      }
    }
    .padding()
    .onAppear {
      Task {
        do {
          try await Task.sleep(nanoseconds: 1_000_000_000)
          progress = model.value
        } catch {}
      }
    }
  }
}

struct AbilityView_Previews: PreviewProvider {
  static var previews: some View {
    AbilityView(model: .init(title: "Test", value: 0.3))
  }
}
