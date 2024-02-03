//
//  Button+CellWrappedView.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit
import WrapperCell

extension Button: CellWrappedView {

    public struct Item {
        let text: TextContent
        let image: UIImage?
        let tintColor: UIColor?
        let backgroundColor: UIColor?
        let disabledBackgroundColor: UIColor?
        let cornerRadius: CGFloat

        init(
            text: TextContent,
            image: UIImage? = nil,
            tintColor: UIColor? = nil,
            backgroundColor: UIColor? = nil,
            disabledBackgroundColor: UIColor? = nil,
            cornerRadius: CGFloat = .zero
        ) {
            self.text = text
            self.image = image
            self.tintColor = tintColor
            self.backgroundColor = backgroundColor
            self.disabledBackgroundColor = disabledBackgroundColor
            self.cornerRadius = cornerRadius
        }
    }

    public func configure(_ item: Item) {
        self.setAttributedTitle(NSAttributedString(from: item.text), for: [])
        self.setImage(item.image, for: [])
        self.tintColor = item.tintColor
        self.defaultBackgroundColor = item.backgroundColor
        self.disabledBackgroundColor = item.disabledBackgroundColor
        self.layer.cornerRadius = item.cornerRadius
        self.isUserInteractionEnabled = false
    }

    public func handleSelection(_ selected: Bool) {
        self.isEnabled = selected
    }

    public func reset() {
        self.setAttributedTitle(nil, for: [])
        self.setImage(nil, for: [])
        self.tintColor = nil
        self.defaultBackgroundColor = nil
        self.disabledBackgroundColor = nil
        self.layer.cornerRadius = .zero
        self.isUserInteractionEnabled = true
    }
}

public typealias ButtonCell = WrapperCell<Button>
