//
//  PKMNView+Modal.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Anchorage
import Foundation

public extension PKMNView {
  func showLoader() {
    let loaderView = PKMNLoader(frame: frame)
    modalViews.append(loaderView)

    func exec() {
      addSubview(loaderView)
      loaderView.edgeAnchors /==/ edgeAnchors
    }

    /// Make sure the code is executed on the main thread
    if Thread.isMainThread {
      exec()
    } else {
      DispatchQueue.main.sync {
        exec()
      }
    }
  }

  func hideLoader(withAction _: (() -> Void)? = nil) {
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
