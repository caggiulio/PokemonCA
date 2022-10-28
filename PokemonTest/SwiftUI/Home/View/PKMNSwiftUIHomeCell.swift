//
//  PKMNSwiftUIHomeCell.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 28/10/22.
//

import SwiftUI

public struct PKMNHomeCell: View {
  /// The `PokemonListItem` model handheld by the `View`.
  let pokemon: PokemonListItem
    
  public var body: some View {
    HStack {
      Spacer()
      
      VStack {
        Text(pokemon.name.capitalized)
          .fontWeight(.bold)
          .font(.title)
          .foregroundColor(Color(uiColor: AppAsset.tertiary.color))
          .padding(.top, 10)
        
        ZStack {
          Image(uiImage: AppAsset.pokeball.image)
            .resizable()
            .frame(width: 120, height: 120)
            .foregroundColor(Color(uiColor: AppAsset.tertiary.color))
          
          AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
            switch phase {
            case .success(let image):
              image
                .resizable()
                .frame(width: 90, height: 90)
              
            default:
              Image(uiImage: AppAsset.pokeball.image)
            }
          }
        }
        .padding(.top, -20)
      }
      
      Spacer()
    }
    .background(Color(uiColor: AppAsset.primary.color))
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}
