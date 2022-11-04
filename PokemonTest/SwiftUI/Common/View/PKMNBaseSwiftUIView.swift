//
//  PKMNBaseSwiftUIView.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

/// The base `View` for the module. It's specialized with a `PKMNModel` and a `Content`.
/// The base `View` handle the generic `LoadingState`.
struct PKMNBaseSwiftUIView<Model: PKMNModel, Content>: View where Content: View {
  // MARK: - Stored Properties
  
  /// The content `View`.
  let content: Content
  
  /// The specialized `PKMNSwiftUIViewModel`.
  let viewModel: PKMNSwiftUIViewModel<Model>
    
  // MARK: - Init
  
  /// The init of the base `View`.
  /// - Parameters:
  ///   - content: the content `View`.
  ///   - viewModel: the specialized `PKMNSwiftUIViewModel`.
  init(@ViewBuilder _ content: () -> Content, viewModel: PKMNSwiftUIViewModel<Model>) {
    self.content = content()
    self.viewModel = viewModel
  }
  
  // MARK: - View
  
  var body: some View {
    ZStack {
      content
    }
    .handleLoadingState(state: viewModel.$loadingState)
  }
}
