//
//  Button.swift
//  WrapperCell_Example
//
//  Created by Kenan Alizadeh on 03.10.23.
//

import UIKit

public class Button: UIButton {

    public var defaultBackgroundColor: UIColor? {
        didSet {
            self.updateBackgroundColor()
        }
    }

    public var disabledBackgroundColor: UIColor? {
        didSet {
            self.updateBackgroundColor()
        }
    }

    override public var isEnabled: Bool {
        didSet {
            self.updateBackgroundColor()
        }
    }

    private var backgroundColorForCurrentState: UIColor? {
        self.isEnabled
        ? self.defaultBackgroundColor
        : self.disabledBackgroundColor
    }

    private func updateBackgroundColor() {

        self.backgroundColor = self.backgroundColorForCurrentState
    }
}
