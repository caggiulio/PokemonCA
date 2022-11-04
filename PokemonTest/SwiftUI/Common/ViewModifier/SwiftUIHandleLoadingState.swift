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
  // MARK: - Stored Properties
  
  /// The current state of a `LoadingState`.
  let state: Published<LoadingState<Model, PKMNError>>.Publisher
  
  // MARK: - Computed Properties
  
  /// The `@State` `Bool` used to show the loader `View`.
  @State private var isLoading: Bool = false
  
  /// The `Binding<Bool>` used to show the alert.
  @State private var isShowingAlert: Bool = false
  
  /// The model for the `PKMNSwiftUIToast`.
  @State private var toastModel: PKMNSwiftUIToastModel?
  
  // MARK: - Interaction
  
  /// The closure with the success `Model`.
  var closureModel: CustomInteraction<Model>?
  
  // MARK: - Body
  
  func body(content: Content) -> some View {
    content
      .overlay {
        if isLoading {
          PKMNSwiftUILoader()
        }
      }
      .overlay(alignment: .top) {
        if let model = toastModel, isShowingAlert {
          PKMNSwiftUIToast(viewModel: model, isShowing: $isShowingAlert) {
            toastModel = nil
          }
        }
      }
      .onReceive(state) { output in
        switch output {
        case .loading(_):
          isLoading = true
          
        case .failure(let error):
          toastModel = PKMNSwiftUIToastModel(status: .failure, message: error.localizedDescription)
          isShowingAlert = true
          isLoading = false
          
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
