//
//  UILabel+ConfigurableView.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 22.04.23.
//

import UIKit
import WrapperCell

extension UILabel: ConfigurableView {

    public struct Item {
        let content: TextContent
        let numberOfLines: Int
        let lineBreakMode: NSLineBreakMode
        let textAlignment: NSTextAlignment
        let baselineAdjustment: UIBaselineAdjustment
        let backgroundColor: UIColor
        let cornerRadius: CGFloat

        init(
            content: TextContent,
            numberOfLines: Int = 1,
            lineBreakMode: NSLineBreakMode = .byTruncatingTail,
            textAlignment: NSTextAlignment = .natural,
            baselineAdjustment: UIBaselineAdjustment = .alignBaselines,
            backgroundColor: UIColor = .clear,
            cornerRadius: CGFloat = .zero
        ) {
            self.content = content
            self.numberOfLines = numberOfLines
            self.lineBreakMode = lineBreakMode
            self.textAlignment = textAlignment
            self.baselineAdjustment = baselineAdjustment
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
        }
    }

    public func configure(_ item: Item) {
        self.setText(content: item.content)
        self.numberOfLines = item.numberOfLines
        self.lineBreakMode = item.lineBreakMode
        self.textAlignment = item.textAlignment
        self.baselineAdjustment = item.baselineAdjustment
        self.backgroundColor = item.backgroundColor
        self.roundCorners(.allCorners, radius: 8)
    }

    public func reset() {
        self.setText(content: nil)
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
        self.textAlignment = .natural
        self.baselineAdjustment = .alignBaselines
        self.backgroundColor = .clear
        self.roundCorners(.allCorners, radius: 0)
    }
}

typealias LabelCell = WrapperCell<UILabel>
