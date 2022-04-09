//
//  PKMNView+Modal.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import Anchorage

public extension PKMNView {
    func showLoader() {
        let loaderView: PKMNLoader = PKMNLoader(frame: self.frame)
        self.modalViews.append(loaderView)
        
        func exec() {
            self.addSubview(loaderView)
            loaderView.edgeAnchors /==/ edgeAnchors
        }
                
        /// Make sure the code is executed on the main thread
        if Thread.isMainThread {
            exec()
        }
        else {
            DispatchQueue.main.sync {
                exec()
            }
        }
    }
    
    func hideLoader(withAction: (() -> Void)? = nil) {
        func exec() {
            modalViews.forEach { loader in
                loader.removeFromSuperview()
            }
        }
        
        if Thread.isMainThread {
            exec()
        } else {
            DispatchQueue.main.sync {
                exec()
            }
        }
    }
}
