//
//  PMKNDetailViewController.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

public protocol PMKNDetailViewControllerProtocol {
    func loadPokemon()
}

public class PKMNDetailViewController: PKMNViewController, PMKNDetailViewControllerProtocol {

    // MARK: - Business logic properties
    
    private var viewModel: PKMNDetailViewModelProtocol

    public weak var detailCoordinator: PKMNPokemonCoordinator?
    
    var _view: PKMNDetailView? {
        guard let view = view as? PKMNDetailView else { preconditionFailure("Unable to cast view to \(PKMNDetailView.self)")}
        return view
    }
    
    // MARK: - Object lifecycle
    
    public init(viewModel: PKMNDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = PKMNDetailView()
    }
    
    public func loadPokemon() {
        viewModel.loadPokemon()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBinds()
        loadPokemon()
    }
    
    private func configureBinds() {
        viewModel.updateStatus = { [weak self] status in
            switch status {
            case .idle:
                break
            case .loading(_):
                self?._view?.showLoader()
            case .success(let pokemon):
                self?._view?.hideLoader()
                self?._view?.configure(pokemon: pokemon)
            case .failure(let error):
                self?._view?.hideLoader()
                self?.handleError(error: error)
            }
        }
    }
}
