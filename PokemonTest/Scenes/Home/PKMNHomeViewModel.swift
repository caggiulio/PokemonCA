//
//  PKMNViewModel.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

public protocol PKMNHomeViewModelProtocol {
    func loadHome(queryItems: [URLQueryItem]?)
    func searchPokemon(name: String)
    func getNextPage()
    func retrievedPokemon() -> [PokemonListItem]
    func pokemon(_ forIndexPath: IndexPath) -> PokemonListItem?
    
    var updateStatus: ((LoadingState<Void, PKMNError>) -> Void)? { get set }
}

public class PKMNHomeViewModel: PKMNHomeViewModelProtocol {
    /// The loading state updates the closure `updateStatus`
    private var loadingState: LoadingState<Void, PKMNError> = .idle {
        didSet {
            self.updateStatus?(self.loadingState)
        }
    }
    /// Use-cases
    private let getPokemonsListUseCase: GetPokemonsListProtocol
    private let searchPokemonByNameUseCase: SearchPokemonByNameProtocol
    /// In this variable are stored the retrieved `PokemonListItem`
    private var retrievedPokemons: [PokemonListItem] = []
    /// In this variable it's stored the url for the next page
    private var nextPage: String?
    /// `DispatchWorkItem` used to search a pokemon
    private var searchTask: DispatchWorkItem?
    
    public var updateStatus: ((LoadingState<Void, PKMNError>) -> Void)?
    
    public init(getPokemonsListUseCase: GetPokemonsListProtocol, searchPokemonByNameUseCase: SearchPokemonByNameProtocol) {
        self.getPokemonsListUseCase = getPokemonsListUseCase
        self.searchPokemonByNameUseCase = searchPokemonByNameUseCase
    }
    
    public func loadHome(queryItems: [URLQueryItem]?) {
        loadingState = .loading(queryItems == nil)
        queryItems == nil ? retrievedPokemons.removeAll() : nil
        
        getPokemonsListUseCase.execute(queryItems: queryItems) { [weak self] result in
            switch result {
            case .success(let pokemonList):
                self?.nextPage = pokemonList.next
                let pokemonItems = pokemonList.pokemonItems
                self?.retrievedPokemons.append(contentsOf: pokemonItems)
                self?.loadingState = .success(())
            case .failure(let error):
                self?.loadingState = .failure(error)
            }
        }
    }
    
    public func getNextPage() {
        /// If `searchTask != nil` a search is in progress.
        guard searchTask == nil else { return }
        guard let next = nextPage else { return }
        guard let nextUrl = URL(string: next) else { return }
        guard let urlComponents = URLComponents(url: nextUrl, resolvingAgainstBaseURL: false) else { return }
        guard let queryItems = urlComponents.queryItems else { return }
        
        loadHome(queryItems: queryItems)
    }
    
    public func retrievedPokemon() -> [PokemonListItem] {
        return retrievedPokemons
    }
    
    public func pokemon(_ indexPath: IndexPath) -> PokemonListItem? {
        return retrievedPokemons[indexPath.item]
    }
    
    public func searchPokemon(name: String) {
        searchTask?.cancel()
        searchTask = nil
        /// If text is empty, we must to reload the lists
        guard !name.isEmpty else {
            loadHome(queryItems: nil)
            return
        }
        
        let task = DispatchWorkItem { [weak self] in
            self?.loadingState = .loading(true)
            self?.searchPokemonByNameUseCase.execute(name: name) { [weak self] result in
                switch result {
                case .success(let pokemonListItems):
                    self?.retrievedPokemons = pokemonListItems
                    self?.loadingState = .success(())
                case .failure(let error):
                    self?.loadingState = .failure(error)
                }
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
}
