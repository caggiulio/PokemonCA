//
//  PKMNSwiftUIToast.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 04/11/22.
//

import SwiftUI

/// A simple toast to show a message.
/// The status will be define the background color.
struct PKMNSwiftUIToast: View {
  // MARK: - Enums
  
  /// The status of the toast view. Will be define the background color.
  enum Status {
    /// The success status.
    case success
    
    /// The failure status.
    case failure
  }
  
  // MARK: - Interactions
  
  /// The dismiss interaction.
  var dismiss: Interaction?
  
  // MARK: - Stored Properties
  
  /// The model of the `View`.
  let viewModel: PKMNSwiftUIToastModel
  
  // MARK: - Init
  
  /// The `init` of the `View`.
  init(viewModel: PKMNSwiftUIToastModel, dismissAction: Interaction?) {
    self.viewModel = viewModel
    self.dismiss = dismissAction
  }
  
  // MARK: - View
  
  var body: some View {
    HStack {
      Image(uiImage: AppAsset.pokeball.image)
        .resizable()
        .frame(width: 50, height: 50)
      
      Text(viewModel.message)
        .font(.body.bold())
        .foregroundColor(.white)
        .padding()
    }
    .padding(.horizontal, 15)
    .background {
      viewModel.backgroundColor
    }
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .task {
      do {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        dismiss?()
      } catch {}
    }
  }
}
