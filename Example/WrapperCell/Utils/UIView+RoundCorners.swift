//
//  UIView+RoundCorners.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 03.10.23.
//

import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
