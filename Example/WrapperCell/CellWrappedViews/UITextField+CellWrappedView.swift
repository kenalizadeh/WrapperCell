//
//  UITextField+CellWrappedView.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 22.04.23.
//

import UIKit
import WrapperCell

extension UITextField: CellWrappedView {

    public struct Item {
        let placeholder: TextContent
        let borderColor: UIColor?
        let cornerRadius: CGFloat?
        let keyboardType: UIKeyboardType
        let autocapitalizationType: UITextAutocapitalizationType
        let textColor: UIColor?
        let font: UIFont?
        let leftView: UIView?
        let rightView: UIView?

        init(
            placeholder: TextContent,
            borderColor: UIColor? = nil,
            cornerRadius: CGFloat? = nil,
            keyboardType: UIKeyboardType = .default,
            autocapitalizationType: UITextAutocapitalizationType = .sentences,
            textColor: UIColor? = nil,
            font: UIFont? = nil,
            leftView: UIView? = nil,
            rightView: UIView? = nil
        ) {
            self.placeholder = placeholder
            self.borderColor = borderColor
            self.cornerRadius = cornerRadius
            self.keyboardType = keyboardType
            self.autocapitalizationType = autocapitalizationType
            self.textColor = textColor
            self.font = font
            self.leftView = leftView
            self.rightView = rightView
        }
    }

    public func configure(_ item: Item) {
        self.attributedPlaceholder = .init(from: item.placeholder)
        self.layer.borderColor = item.borderColor?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = item.cornerRadius ?? 0
        self.keyboardType = item.keyboardType
        self.autocapitalizationType = item.autocapitalizationType
        self.textColor = item.textColor
        self.font = item.font
        self.leftView = item.leftView
        self.leftViewMode = .always
        self.rightView = item.rightView
        self.rightViewMode = .always
    }

    public func reset() {
        self.attributedPlaceholder = nil
        self.layer.borderColor = nil
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        self.keyboardType = .default
        self.autocapitalizationType = .sentences
        self.textColor = nil
        self.font = nil
        self.leftView = nil
        self.leftViewMode = .never
        self.rightView = nil
        self.rightViewMode = .never
    }
}

typealias TextFieldCell = WrapperCell<UITextField>
