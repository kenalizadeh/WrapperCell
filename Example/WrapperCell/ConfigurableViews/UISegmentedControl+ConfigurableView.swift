//
//  UISegmentedControl+ConfigurableView.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit
import WrapperCell

extension UISegmentedControl: ConfigurableView {

    public struct Item {
        let items: [String]
        let font: UIFont
        let textColor: UIColor
    }

    public func configure(_ item: Item) {
        item.items.reversed().forEach {
            self.insertSegment(withTitle: $0, at: 0, animated: true)
        }
        self.setTitleTextAttributes(
            [
                .foregroundColor: item.textColor,
                .font: item.font
            ],
            for: []
        )
        self.selectedSegmentIndex = 0
    }

    public func reset() {

    }
}

typealias SegmentCell = WrapperCell<UISegmentedControl>
