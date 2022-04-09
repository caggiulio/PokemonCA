//
//  PKMNViewController+Modal.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import Anchorage

public extension PKMNViewController {
    func showToast(color: UIColor, text: String, completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            let toast = PKMNToast(frame: .zero, color: color, text: text)
            
            toast.dismiss = {
                dismiss()
            }
            
            self.view.addSubview(toast)
            setToastConstraints(_view: self.view)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut) {
                toast.transform = .init(translationX: 0, y: 80 + (UIApplication.shared.statusBarFrame.height))
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
            
            func dismiss() {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    toast.transform = .identity
                }) { _ in
                    toast.removeFromSuperview()
                    completion?()
                }
                
                return
            }
        }
    }
}
