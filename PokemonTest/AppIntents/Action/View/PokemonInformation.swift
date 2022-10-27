//
//  PokemonInformation.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 27/10/22.
//

import SwiftUI

@available(iOS 16.0, *)
struct PokemonInformation: View {
  let pokemon: PokemonAppEntity
  
  var body: some View {
    VStack {
      Text(pokemon.name)
        .font(.title)
        .bold()
        .padding(.top)
      
      Image(uiImage: AppAsset.pokeball.image)
    }
  }
}
