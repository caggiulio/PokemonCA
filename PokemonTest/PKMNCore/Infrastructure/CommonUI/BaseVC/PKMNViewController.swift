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
  
  public var _view: View {
    guard let view = view as? View else { preconditionFailure("Unable to cast view to \(View.self)") }
    return view
  }
  
  public let viewModel: ViewModel
  
  override public func loadView() {
    view = View()
  }
  
  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()

    configureBinds()
    setup()
  }

  private func setup() {
    navigationController?.view.backgroundColor = PKMNThemeManager.currentTheme().navigationBarBackgroundColor
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureBinds() {
    viewModel.updateStatus = { [weak self] status in
      guard let self = self else {
        return
      }
      
      self.handle(self.viewModel.loadingState)
    }
  }
}
