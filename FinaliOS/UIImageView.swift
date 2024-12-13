//
//  UIImageView.swift
//  FinaliOS
//
//  Created by Gurpreet Singh on 2024-12-13.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
