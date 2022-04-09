//
//  JSONDataSourceWorker.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

class JSONDataSourceWorker: JSONDataSourceProtocol {
    
    func getPokemon(completion: (Result<Pokemon, PKMNError>) -> Void) {
        let decoder = JSONDecoder()
        let fileName = JSONFilesNames.singlePokemon
        
        guard let url = PKMNDataBundleResolver.returnMainBundle().url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url), let dataSource = try? decoder.decode(PokemonDataSource.self, from: data)
           else {
               completion(.failure(.genericError(PKMNString.standardError)))
               return
           }
        
        let pokemon = Pokemon(pokemonDataSource: dataSource)
        completion(.success(pokemon))
    }
    
    func pokemonsList(completion: (Result<PokemonsList, PKMNError>) -> Void) {
        let decoder = JSONDecoder()
        let fileName = JSONFilesNames.pokemonsList
        
        guard let url = PKMNDataBundleResolver.returnMainBundle().url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url), let dataSource = try? decoder.decode(PokemonListDataSource.self, from: data)
           else {
               completion(.failure(.genericError(PKMNString.standardError)))
               return
           }
        
        let pokemonsList = PokemonsList(pokemonsListDataSource: dataSource)
        completion(.success(pokemonsList))
    }
}
