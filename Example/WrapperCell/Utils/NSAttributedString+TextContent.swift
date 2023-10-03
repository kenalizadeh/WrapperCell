//
//  NSAttributedString+TextContent.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 03.10.23.
//

import Foundation

extension NSAttributedString {

    convenience init(from content: TextContent) {

        self.init(
            string: content.string,
            attributes: [
                .font: content.font,
                .foregroundColor: content.color
            ]
        )
    }
}
