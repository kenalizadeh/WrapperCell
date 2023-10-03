//
//  UIImageView+ConfigurableView.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit
import WrapperCell

extension UIImageView: ConfigurableView {

    public struct Item {
        let contentMode: UIControl.ContentMode
        let image: UIImage?
        let tintColor: UIColor?
    }

    public func configure(_ item: Item) {
        self.contentMode = item.contentMode
        self.image = item.image
        self.tintColor = item.tintColor
    }

    public func reset() {
        self.contentMode = .center
        self.image = nil
        self.tintColor = nil
    }
}

typealias ImageCell = WrapperCell<UIImageView>
