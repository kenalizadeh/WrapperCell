//
//  CGRect+Padding.swift
//  WrapperCell
//
//  Created by Kenan Alizadeh on 03.10.23.
//

import UIKit

public extension CGRect {
    func padded(by insets: UIEdgeInsets) -> CGRect {
        inset(by: UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right))
    }
}
