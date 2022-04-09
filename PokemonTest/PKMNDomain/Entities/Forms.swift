//
//  Forms.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct Forms {
    let name: String
    
    public init(formsDataSource: FormsDataSource) {
        name = formsDataSource.name
    }
}
