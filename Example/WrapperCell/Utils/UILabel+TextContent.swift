//
//  UILabel+TextContent.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 03.10.23.
//

import UIKit

extension UILabel {

    func setText(content: TextContent?) {

        guard var content
        else {
            self.resetTextContent()
            return
        }

        self.text = content.string
        self.textColor = content.color
        self.font = content.font
    }

    func setAttributedText(content: TextContent?) {

        guard var content
        else {
            self.resetTextContent()
            return
        }

        self.attributedText = NSAttributedString(from: content)
    }

    func resetTextContent() {
        self.text = nil
        self.textColor = nil
        self.font = nil
    }
}
