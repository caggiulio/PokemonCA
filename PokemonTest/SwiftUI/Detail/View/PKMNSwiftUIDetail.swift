//
//  PKMNSwiftuiDetail.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 30/10/22.
//

import SwiftUI

struct PKMNSwiftUIDetail: View {
  
  // MARK: - Stored Properties
  
  /// The `PKMNSwiftUIViewModel` of the view.
  @StateObject var viewModel: PKMNSwiftUIDetailViewModel
  
  // MARK: - View
  
    var body: some View {
      PKMNBaseSwiftUIView({
        VStack {
          if let model = viewModel.lastValueModel {
            PKMNDetailHeader(pokemon: model.pokemon)
            PKMNDetailAbilitiesList(abilities: model.abilities)
          }
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: AppAsset.primary.color))
        .onAppear {
          viewModel.getPokemonDetails()
        }
      }, viewModel: viewModel)
    }
}

// MARK: - Private View

private extension PKMNSwiftUIDetail {
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
  
  /// The `View` for list of the abilities.
  struct PKMNDetailAbilitiesList: View {
    // MARK: - Stored Properties
    
    /// The list of `AbilityModel`.
    private let abilities: [AbilityModel]
    
    // MARK: - Init
    
    /// The init of the `View`.
    /// - Parameter abilities: the list of `AbilityModel`.
    init(abilities: [AbilityModel]) {
      self.abilities = abilities
    }
    
    // MARK: - View
    
    var body: some View {
      VStack {
        ScrollView {
          ForEach(abilities) { ability in
            AbilityView(model: ability)
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(uiColor: AppAsset.tertiary.color))
      .clipShape(RoundedRectangle(cornerRadius: 20))
    }
  }
}
