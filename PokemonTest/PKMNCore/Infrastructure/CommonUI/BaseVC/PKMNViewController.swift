//
//  PKMNViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import UIKit

public class PKMNViewController<Model: PKMNModel, View: PKMNView<Model>, ViewModel: PKMNViewModel<Model>> : UIViewController {
  
  /// This is the error handler that handle ONLY the `PKMNError`
  public var errorHandler: ErrorHandleable?
  
  /// The `PKMNView` of the controller.
  public var rootView: View {
    guard let view = view as? View else { preconditionFailure("Unable to cast view to \(View.self)") }
    return view
  }
  
  /// The `PKMNViewModel` of the controller.
  public let viewModel: ViewModel
  
  // MARK: - Object Lyfecycle
  
  /// Load the custom related `PKMNView`.
  override public func loadView() {
    view = View()
  }
  
  // MARK: - Init
  
  /// The init of the controller.
  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Object Lyfecycle
  
  override public func viewDidLoad() {
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
