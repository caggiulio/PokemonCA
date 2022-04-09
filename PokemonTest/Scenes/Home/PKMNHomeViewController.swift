//
//  PKMNHomeViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

public protocol PKMNHomeViewControllerProtocol {
    func loadHome()
    func searchPokmemon(name: String)
}

public class PKMNHomeViewController: PKMNViewController, PKMNHomeViewControllerProtocol {

    // MARK: - Business logic properties
    
    private var viewModel: PKMNHomeViewModelProtocol

    public weak var homeCoordinator: PKMNPokemonCoordinatorProtocol?
    
    var _view: PKMNHomeView? {
        guard let view = view as? PKMNHomeView else { preconditionFailure("Unable to cast view to \(PKMNHomeView.self)")}
        return view
    }
    
    // MARK: - Object lifecycle
    
    public init(viewModel: PKMNHomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = PKMNHomeView()
    }
    
    public func loadHome() {
        viewModel.loadHome(queryItems: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = PKMNString.homeTitle
        setupNavigationBar()
        configureBinds()
        setDelegates()
        loadHome()
    }
    
    public func searchPokmemon(name: String) {
        viewModel.searchPokemon(name: name)
    }
    
    private func configureBinds() {
        viewModel.updateStatus = { [weak self] status in
            switch status {
            case .idle:
                self?._view?.hideLoader()
            case .loading(let isFirstLoading):
                isFirstLoading ? self?._view?.showLoader() : nil
            case .success:
                self?._view?.hideLoader()
                self?.reloadData()
                break
            case .failure(let error):
                self?._view?.hideLoader()
                self?.handleError(error: error)
            }
        }
    }
    
    private func setDelegates() {
        _view?.collectionView.dataSource = self
        _view?.collectionView.delegate = self
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self._view?.collectionView.reloadData()
        }
    }
}

extension PKMNHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.retrievedPokemon().count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PKMNHomeCollectionViewCell = collectionView.dequeueReusableCell(PKMNHomeCollectionViewCell.self, for: indexPath)
        guard let pokemonItem = viewModel.pokemon(indexPath) else { return cell }
        cell.configure(pokemon: pokemonItem)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width) - 30
        let height = width / 2
        
        return .init(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.isLastRow(at: collectionView) {
            viewModel.getNextPage()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.pokemon(indexPath)?.id else { return }
        
        homeCoordinator?.routeToDetail(pokemonID: id)
    }
}
