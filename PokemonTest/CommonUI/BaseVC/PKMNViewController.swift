//
//  PKMNViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import UIKit

class PKMNViewController<Model: PKMNModel, View: PKMNView<Model>, ViewModel: PKMNViewModel<Model>> : UIViewController {
  
  /// This is the error handler that handle ONLY the `PKMNError`
  var errorHandler: ErrorHandleable?
  
  /// The `PKMNView` of the controller.
  var rootView: View {
    guard let view = view as? View else { preconditionFailure("Unable to cast view to \(View.self)") }
    return view
  }
  
  /// The `PKMNViewModel` of the controller.
  let viewModel: ViewModel
  
  // MARK: - Object Lyfecycle
  
  /// Load the custom related `PKMNView`.
  override func loadView() {
    view = View()
  }
  
  // MARK: - Init
  
  /// The init of the controller.
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Object Lyfecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureBinds()
    handleError()
    setup()
  }
}

private extension PKMNViewController {
  /// The generic setup for the controller.
  func setup() {
    navigationController?.view.backgroundColor = PKMNThemeManager.currentTheme().navigationBarBackgroundColor
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  /// Listen and handle the `LoadingState`.
  func configureBinds() {
    viewModel.updateStatus = { [weak self] loadingState in
      self?.handle(loadingState)
    }
  }
}
