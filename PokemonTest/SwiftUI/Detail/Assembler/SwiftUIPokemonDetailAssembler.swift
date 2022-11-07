//
//  SwiftUIPokemonDetailAssembler.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 30/10/22.
//

import Foundation

// MARK: - PKMNSwiftUIHomeAssembler

struct PKMNSwiftUIDetailAssembler: PKMNSwiftUIDetailAssemblerInjector {
  @Inject private var mainAssembler: PKMNSwiftUIAssembler
  @Inject private var container: PKMNMainContainer
  var id: String

  init(id: String) {
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

