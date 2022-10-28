//
//  PKMNSwiftUILoader.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import SwiftUI

/// The `View` for the home.
public struct PKMNSwiftUILoader: View {
  
  @State private var isAnimating = false
  
  var foreverAnimation: Animation {
    Animation.linear(duration: 1.0)
      .repeatForever(autoreverses: false)
  }
  
  public var body: some View {
    ZStack {
      Image(uiImage: AppAsset.pokeball.image)
        .resizable()
        .frame(width: 120, height: 120)
        .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
        .animation(foreverAnimation, value: self.isAnimating ? foreverAnimation : .default)
        .onAppear { self.isAnimating = true }
        .onDisappear { self.isAnimating = false }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white.opacity(0.75))
  }
}
