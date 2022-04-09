//
//  PKMNDetailAssembler.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import Inject

// MARK: - PKMNDetailAssembler

public class PKMNDetailAssembler: PKMNDetailAssemblerInjector {
  var container: PKMNMainContainerProtocol
  var id: String

  public init(container: PKMNMainContainerProtocol, id: String) {
    self.container = container
    self.id = id
  }
}

// MARK: - PKMNDetailAssemblerInjector

public protocol PKMNDetailAssemblerInjector {
  func resolve() -> _InjectableViewControllerHost<PKMNDetailViewController>

  func resolve() -> PKMNDetailViewModel
}

public extension PKMNDetailAssembler {
  func resolve() -> _InjectableViewControllerHost<PKMNDetailViewController> {
    return Inject.ViewControllerHost(PKMNDetailViewController(viewModel: self.resolve()))
  }

  func resolve() -> PKMNDetailViewModel {
    return PKMNDetailViewModel(getPokemonByIDUseCase: container.getPokemonByIDUseCase, id: id)
  }
}
