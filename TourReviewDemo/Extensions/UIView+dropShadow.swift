//
//  UIView+dropShadow.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 12.07.2024.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1
    }
}
