//
//  PKMNViewController+Modal.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Anchorage
import Foundation

extension PKMNViewController {
  /// Shows a toast with a `color`, a `text` and return an optional `completion`.
  /// - Parameters
  ///   - color: the `UIColor` of the background.
  ///   - text: the `String` to show.
  ///   - completion: the optional `closure` to make somthing after the view is presented.
  func showToast(color: UIColor, text: String, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      let toast = PKMNToast(frame: .zero, color: color, text: text)

      toast.dismiss = {
        dismiss()
      }

      self.view.addSubview(toast)
      setToastConstraints(_view: self.view)

      UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut) {
        toast.transform = .init(translationX: 0, y: 80 + (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0))
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
        dismiss()
      }

      func setToastConstraints(_view: UIView) {
        toast.bottomAnchor /==/ _view.topAnchor
        toast.leftAnchor /==/ _view.leftAnchor + 15
        toast.rightAnchor /==/ _view.rightAnchor - 15
        toast.heightAnchor /==/ 80
        _view.layoutIfNeeded()
      }

      /// Dismiss the toast view and return an optional `completion` to make something after the view is dismissed.
      func dismiss() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
          toast.transform = .identity
        }) { _ in
          toast.removeFromSuperview()
          completion?()
        }
      }
    }
  }
}
