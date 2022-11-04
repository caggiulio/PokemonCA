//
//  SwiftUIPokemonDetailAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 30/10/22.
//

import Foundation

// MARK: - PKMNSwiftUIHomeAssembler

struct PKMNSwiftUIDetailAssembler: PKMNSwiftUIDetailAssemblerInjector {
  var container: PKMNMainContainerProtocol
  var mainAssembler: PKMNSwiftUIAssembler
  var id: String

  init(container: PKMNMainContainerProtocol, mainAssembler: PKMNSwiftUIAssembler, id: String) {
    self.container = container
    self.mainAssembler = mainAssembler
    self.id = id
  }
}

// MARK: - PKMNSwiftUIDetailAssemblerInjector

protocol PKMNSwiftUIDetailAssemblerInjector {
  func resolve() -> PKMNSwiftUIDetail
  
  func resolve() -> PKMNSwiftUIDetailViewModel
}

extension PKMNSwiftUIDetailAssembler {
  func resolve() -> PKMNSwiftUIDetail {
    PKMNSwiftUIDetail(viewModel: self.resolve())
  }
  
  func resolve() -> PKMNSwiftUIDetailViewModel {
    PKMNSwiftUIDetailViewModel(getPokemonDetailUseCase: container.asyncGetPokemonByIDUseCase, id: id)
  }
}

