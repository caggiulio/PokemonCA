//
//  SwiftUIHandleLoadingState.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

/// The `ViewModifier` to handle the `LoadingState`.
/// The `Model` is the generic `PKMNModel` that a `View` can handle.
struct HandleLoadingState<Model: PKMNModel>: ViewModifier {
  /// The current state of a `LoadingState`.
  let state: Published<LoadingState<Model, PKMNError>>.Publisher
  
  /// The closure with the success `Model`.
  var closureModel: ((Model) -> Void)?
  
  /// The `@State` `Bool` used to show the loader `View`.
  @State private var isLoading: Bool = false
  
  /// The `@State` `Bool` used to show the error `View`.
  @State private var isError: Bool = false
  
  /// The `String` used to show the error message.
  @State private var errorMessage = String()
  
  func body(content: Content) -> some View {
    content
      .overlay {
        if isLoading {
          PKMNSwiftUILoader()
        }
        if isError {
          PKMNSwiftUIToast(viewModel: PKMNSwiftUIToastModel(status: .failure, message: errorMessage)) {
            withAnimation {
              isError = false
            }
          }
        }
      }
      .onReceive(state) { output in
        switch output {
        case .loading(_):
          isLoading = true
          
        case .failure(let error):
          errorMessage = error.localizedDescription
          isLoading = false
          isError = true
          
        case .success(let value):
          isLoading = false
          closureModel?(value)
          
        case .idle:
          break
        }
      }
  }
}

extension View {
  func handleLoadingState<Model: PKMNModel>(state: Published<LoadingState<Model, PKMNError>>.Publisher, perform closureModel: ((Model) -> Void)? = nil) -> some View {
    modifier(HandleLoadingState(state: state, closureModel: closureModel))
  }
}
