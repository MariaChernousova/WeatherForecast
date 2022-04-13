//
//  UIImageView+Extensions.swift
//  hw14
//
//  Created by Chernousova Maria on 07.11.2021.
//

import UIKit

extension UIImageView {
    private enum Constant {
        static let animationDuration: TimeInterval = 0.3
        static let animationOpacity: Float = 1
    }
    
    func loadImage(from url: URL?) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil,
                    let data = data else { return }
            
            DispatchQueue.main.async {
                self.layer.opacity = .zero
                self.image = UIImage(data: data)
                UIView.animate(withDuration: Constant.animationDuration) {
                    self.layer.opacity = Constant.animationOpacity
                }
            }
        }).resume()
    }
}
