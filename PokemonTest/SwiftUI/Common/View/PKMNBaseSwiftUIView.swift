//
//  PKMNBaseSwiftUIView.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

#warning("This View is experimental")
struct PKMNBaseSwiftUIView<Model: PKMNModel, Content>: View where Content: View {
  let content: Content
  let viewModel: PKMNSwiftUIViewModel<Model>
  
  @State var model: Model?
  
  init(@ViewBuilder _ content: () -> Content, viewModel: PKMNSwiftUIViewModel<Model>) {
    self.content = content()
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      content
    }
    .handleLoadingState(state: viewModel.$loadingState) { model in
      self.model = model
    }
  }
}
