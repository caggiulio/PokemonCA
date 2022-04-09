//
//  FrontImage.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public struct FrontImage {
    public let stringURL: String
    
    init(spritesDataSource: SpritesDataSource) {
        stringURL = spritesDataSource.officialArtwork.frontDefault
    }
}
