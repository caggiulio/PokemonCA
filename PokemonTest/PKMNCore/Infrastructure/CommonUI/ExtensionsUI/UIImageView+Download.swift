//
//  UIImageView+Download.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import UIKit

extension UIImageView {
  private func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, fillBackgroundWithView: UIView? = nil, completion: ((UIImage.Colors?) -> Void)?) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
      else { return }
      DispatchQueue.main.async { [weak self] in
        self?.image = image

        if let view = fillBackgroundWithView {
          image.getColors(quality: .custom(20)) { colors in
            view.backgroundColor = colors?.background
            completion?(colors)
          }
        }
      }
    }.resume()
  }

  func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit, fillBackgroundWithView: UIView? = nil, completion: ((UIImage.Colors?) -> Void)? = nil) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode, fillBackgroundWithView: fillBackgroundWithView) { colors in
      completion?(colors)
    }
  }
}
