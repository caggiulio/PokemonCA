//
//  PKMNDetailHeader.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 11/11/22.
//

import SwiftUI

/// The header of the `View`.
struct PKMNDetailHeader: View {
  // MARK: - Stored Properties
  
  /// The `Pokemon` handeld by the `View`.
  private let pokemon: Pokemon
  
  // MARK: - Init
  
  /// The init of the `View`.
  /// - Parameter pokemon: the `Pokemon` handeld by the `View`.
  init(pokemon: Pokemon) {
    self.pokemon = pokemon
  }
  
  // MARK: - View
  
  var body: some View {
    VStack {
      Text(pokemon.name.capitalized)
        .fontWeight(.bold)
        .font(.title)
        .foregroundColor(Color(uiColor: AppAsset.background.color))
      ZStack {
        Image(uiImage: AppAsset.pokeball.image)
          .resizable()
          .frame(width: 250, height: 250)
          .foregroundColor(Color(uiColor: AppAsset.tertiary.color))
        
        AsyncImage(url: URL(string: pokemon.frontImage.stringURL)) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .frame(width: 185, height: 185)
            
          default:
            Image(uiImage: AppAsset.pokeball.image)
          }
        }
      }
      .frame(height: 200)
    }
  }
}
