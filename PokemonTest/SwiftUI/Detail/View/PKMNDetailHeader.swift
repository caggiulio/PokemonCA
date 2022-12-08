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
  
  /// The `OverallModel` for the `OverallView`.
  private let overallModel: OverallModel
  
  // MARK: - Init
  
  /// The init of the `View`.
  /// - Parameters:
  ///   - pokemon: The `Pokemon` handeld by the `View`.
  ///   - overallModel: The `OverallModel` for the `OverallView`.
  init(pokemon: Pokemon, overallModel: OverallModel) {
    self.pokemon = pokemon
    self.overallModel = overallModel
  }
  
  // MARK: - View
  
  var body: some View {
    VStack {
      Text(pokemon.name.capitalized)
        .fontWeight(.bold)
        .font(.largeTitle)
        .foregroundColor(Color(uiColor: AppAsset.background.color))
      
      Spacer(minLength: 30)
      
      OverallView({
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
      }, model: overallModel)
    }
  }
}
