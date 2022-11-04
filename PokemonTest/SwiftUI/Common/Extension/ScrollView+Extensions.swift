//
//  ScrollView+Extensions.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 29/10/22.
//

import SwiftUI

extension ScrollView {
  /// This workaround is needed to understand when a `ScrollView` reach the ends.
  /// When this occurs, perform the `action`.
  func onReachTheEnd(perform action: (() -> Void)? = nil) -> some View {
    return ScrollView<LazyVStack> {
      LazyVStack {
        self.content
        Rectangle()
          .size(.zero)
          .onAppear {
          action?()
        }
      }
    }
  }
}
