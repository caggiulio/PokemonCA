//
//  PKMNHomeAssembler.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import Inject

public class PKMNHomeAssembler: PKMNHomeAssemblerInjector {
    var container: PKMNMainContainerProtocol
    
    public init(container: PKMNMainContainerProtocol) {
        self.container = container
    }
}

public protocol PKMNHomeAssemblerInjector {
    func resolve() -> _InjectableViewControllerHost<PKMNHomeViewController>
    
    func resolve() -> PKMNHomeViewModel
}

extension PKMNHomeAssembler {
  public func resolve() -> _InjectableViewControllerHost<PKMNHomeViewController> {
    return Inject.ViewControllerHost(PKMNHomeViewController(viewModel: self.resolve()))
    }
    
    public func resolve() -> PKMNHomeViewModel {
        return PKMNHomeViewModel(getPokemonsListUseCase: container.getPokemonsListUseCase, searchPokemonByNameUseCase: container.searchPokemonByNameUseCase)
    }
}
